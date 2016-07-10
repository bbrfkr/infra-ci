require 'docker_container/spec_helper.rb'

describe file("/root") do
  it { should exist }
end
