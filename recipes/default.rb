#
# Cookbook Name:: search_woes
# Recipe:: default
#
# Copyright (c) 2015 Jordan Wesolowski, All Rights Reserved.

env_search = search(:node, 'chef_environment:production')
ip_search = search(:node, 'ipaddress:1.1.1.1')

## One solution would be to double-check our returned nodes after
## we get out search results. This seems like an ugly solution though...
# env_search.select! { |n| n.chef_environment.eql?('production') }
# ip_search.select! { |n| n['ipaddress'].eql?('1.1.1.1') }

template '/tmp/environment_search.txt' do
  variables results: env_search
end

template '/tmp/ipaddress_search.txt' do
  variables results: ip_search
end
