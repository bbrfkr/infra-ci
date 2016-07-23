require 'docker_minidlna/spec_helper'

describe ("docker_minidlna") do
  describe("check service is running") do
    describe service("minidlna") do
      it { should be_running }
    end
  end
end
