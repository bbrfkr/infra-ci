require 'docker_japanese/spec_helper'

describe ("docker_japanese") do
  describe("check locale") do
    describe file('/root/.profile') do
      it { should contain "export LANG=#{property['docker_japanese']['locale']}" }
    end
  end
end
