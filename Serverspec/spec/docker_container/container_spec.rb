require 'docker_container/spec_helper.rb'

describe file("/saito") do
  it { should exist }
end
