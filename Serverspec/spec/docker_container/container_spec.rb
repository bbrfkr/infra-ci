require 'docker_container/spec_helper.rb'

describe file("/") do
  it { should exist }
end
