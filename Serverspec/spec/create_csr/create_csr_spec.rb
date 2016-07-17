require 'create_csr/spec_helper.rb'

dir = property['create_csr']['csrs_and_keys_dir']

describe ("create_csr") do
  property['create_csr']['csrs'].each do |csr|
    describe ("check private key passphrase") do
      private_key = csr['private_key']
      describe command("openssl rsa -in #{dir}/#{private_key['filename']} -passin pass:#{private_key['passphrase']}") do
        its(:exit_status) { should eq 0 }
      end
    end

    describe ("check DN of CA cert") do
      dn = csr['distinguished_name']
      describe command("openssl req -in #{dir}/#{csr['filename']} -noout -subject") do
        its(:stdout) { should eq "subject=/C=#{dn['country']}/ST=#{dn['state']}/L=#{dn['locality_name']}/O=#{dn['organization']}/OU=#{dn['unit_name']}/CN=#{dn['common_name']}\n" }
      end
    end

    describe ("check cert type") do
      if csr['type'] == "server"
        describe command("openssl req -in #{dir}/#{csr['filename']} -noout -text | grep \"TLS Web Server Authentication\"") do
          its(:exit_status) { should eq 0 }
        end
      end
      if csr['type'] == "client"
        describe command("openssl req -in #{dir}/#{csr['filename']} -noout -text | grep \"TLS Web Client Authentication\"") do
          its(:exit_status) { should eq 0 }
        end
      end
    end

    if defined? csr['distinguished_name']['san']
      describe ("check san (dns)") do
        csr['distinguished_name']['san']['dns'].each do |dns|
          describe command("openssl req -in #{dir}/#{csr['filename']} -noout -text | grep \"DNS:#{dns['alias']}\"") do
            its(:exit_status) { should eq 0 }
          end
        end
        csr['distinguished_name']['san']['ip'].each do |ip|
          describe command("openssl req -in #{dir}/#{csr['filename']} -noout -text | grep \"IP Address:#{ip['alias']}\"") do
            its(:exit_status) { should eq 0 }
          end
        end
      end
    end
  end
end
