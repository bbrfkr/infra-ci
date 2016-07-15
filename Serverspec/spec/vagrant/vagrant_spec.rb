require 'virtualbox/spec_helper.rb'

describe ("vagrant") do
  describe ("check installed rpm") do
    describe package("vagrant") do
      it { should be_installed }
    end
  end
end
