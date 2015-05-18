require 'spec_helper'

describe file('/tmp/environment_search.txt') do
  its(:content) do
    is_expected.to eq("alice IN production\n")
  end
end

describe file('/tmp/ipaddress_search.txt') do
  its(:content) do
    is_expected.to eq("alice AT 1.1.1.1\n")
  end
end
