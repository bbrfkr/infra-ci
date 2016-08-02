require 'docker_samba/spec_helper'

describe ("docker_samba") do
  describe ("check service is running") do
    describe service("smbd") do
      it { should be_running}
    end
    describe service("nmbd") do
      it { should be_running}
    end
  end
end
