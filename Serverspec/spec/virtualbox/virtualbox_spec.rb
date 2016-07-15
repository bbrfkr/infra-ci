require 'virtualbox/spec_helper.rb'

describe ("virtualbox") do
  describe ("check version") do
    describe command("VBoxManage --version") do
      its(:stdout) { should match /^#{property['virtualbox']['version']}/ }
    end
  end

  property['virtualbox']['vboxusers'].each do |vboxuser|
    describe ("check #{vboxuser} belongs to vboxusers group") do
      describe user("#{vboxuser}") do
        it { should belong_to_group 'vboxuser' }
      end
    end
  end
end
