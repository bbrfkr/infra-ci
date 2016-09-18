require 'ansible_keyfiles/spec_helper'

describe ("ansible_keyfiles") do
  describe ("check keyfiles dir is created") do
    describe file('/var/ansible_keyfiles') do
      it { should be_directory }
    end
  end
end
