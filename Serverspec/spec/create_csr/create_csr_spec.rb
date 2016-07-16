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
  end
end
