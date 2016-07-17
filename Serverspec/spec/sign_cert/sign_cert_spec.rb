require 'sign_cert/spec_helper.rb'

certs = property['sign_cert']['certs']
dir = property['sign_cert']['certs_dir']

certs.each do |cert|
  describe ("sign_cert") do
    describe ("check DN of cert") do
      dn = cert['distinguished_name']
      describe command("openssl x509 -in #{dir}/#{cert['filename']} -noout -subject") do
        its(:stdout) { should eq "subject= /C=#{dn['country']}/ST=#{dn['state']}/L=#{dn['locality_name']}/O=#{dn['organization']}/OU=#{dn['unit_name']}/CN=#{dn['common_name']}\n" }
      end
    end

    describe ("check cert type") do
      if cert['type'] == "server"
        describe command("openssl x509 -in #{dir}/#{cert['filename']} -noout -text | grep \"TLS Web Server Authentication\"") do
          its(:exit_status) { should eq 0 }
        end
      end
      if cert['type'] == "client"
        describe command("openssl x509 -in #{dir}/#{cert['filename']} -noout -text | grep \"TLS Web Client Authentication\"") do
          its(:exit_status) { should eq 0 }
        end
      end
    end

    if defined? cert['distinguished_name']['san']
      describe ("check san") do
        cert['distinguished_name']['san']['dns'].each do |dns|
          describe command("openssl x509 -in #{dir}/#{cert['filename']} -noout -text | grep \"DNS:#{dns['alias']}\"") do
            its(:exit_status) { should eq 0 }
          end
        end
        cert['distinguished_name']['san']['ip'].each do |ip|
          describe command("openssl x509 -in #{dir}/#{cert['filename']} -noout -text | grep \"IP Address:#{ip['alias']}\"") do
            its(:exit_status) { should eq 0 }
          end
        end
      end
    end

    describe ("check validity term of CA cert") do
      startdate = Specinfra::backend.run_command("date -d \"`openssl x509 -in #{dir}/#{cert['filename']} -noout -startdate | cut -c 11-30`\" +%s")[:stdout]
      enddate = Specinfra::backend.run_command("date -d \"`openssl x509 -in #{dir}/#{cert['filename']} -noout -enddate | cut -c 10-29`\" +%s")[:stdout]
      validity_term = (enddate.to_i - startdate.to_i)/86400
      it { validity_term.should eq("#{cert['validity_term']}".to_i)}
    end
  end
end
