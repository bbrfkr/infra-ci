require 'private_ca/spec_helper.rb'

cert = property['private_ca']['ca_cert']

describe ("private_ca") do
  describe ("check private key and CA cert") do
    describe file("/etc/pki/CA/private/cakey.pem") do
      it { should exist }
    end
    describe file("/etc/pki/CA/cacert.pem") do
      it { should exist }
    end
  end

  describe ("check CA private key passphrase") do
    private_key = cert['private_key']
    describe command("openssl rsa -in /etc/pki/CA/private/cakey.pem -passin pass:#{private_key['passphrase']}") do
      its(:exit_status) { should eq 0 }
    end
  end


  describe ("check DN of CA cert") do
    dn = cert['distinguished_name']
    describe command("openssl x509 -in /etc/pki/CA/cacert.pem -noout -subject") do
      its(:stdout) { should eq "subject= /C=#{dn['country']}/ST=#{dn['state']}/L=#{dn['locality_name']}/O=#{dn['organization']}/OU=#{dn['unit_name']}/CN=#{dn['common_name']}\n" }
    end
  end

  describe ("check validity term of CA cert") do
    startdate = Specinfra::backend.run_command("date -d \"`openssl x509 -in /etc/pki/CA/cacert.pem -noout -startdate | cut -c 11-30`\" +%s")[:stdout]
    enddate = Specinfra::backend.run_command("date -d \"`openssl x509 -in /etc/pki/CA/cacert.pem -noout -enddate | cut -c 10-29`\" +%s")[:stdout]
    validity_term = (enddate.to_i - startdate.to_i)/86400
    it { validity_term.should eq("#{cert['validity_term']}".to_i)}
  end
end
