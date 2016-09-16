require 'docker_ssh/spec_helper'

describe ("docker_ssh") do
  describe("check service is running") do
    describe service("sshd") do
      it { should be_running }
    end
  end
end
