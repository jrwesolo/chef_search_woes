#
# Cookbook Name:: search_woes
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'search_woes::default' do
  subject(:chef_run) do
    runner = ChefSpec::ServerRunner.new

    alice = stub_node('alice') do |node|
      node.automatic['ipaddress'] = '1.1.1.1'
      node.chef_environment = 'production'
    end
    runner.create_node(alice)

    bob = stub_node('bob') do |node|
      node.automatic['ipaddress'] = '2.2.2.2'
      node.chef_environment = 'development'
    end
    runner.create_node(bob)

    runner.converge(described_recipe)
  end

  context 'WITHOUT conflicting nested attributes' do
    it 'finds only "alice" when looking for production nodes' do
      is_expected.to render_file('/tmp/environment_search.txt')
        .with_content(eq("alice IN production\n"))
    end

    it 'finds only "alice" when looking for nodes with ip address "1.1.1.1"' do
      is_expected.to render_file('/tmp/ipaddress_search.txt')
        .with_content(eq("alice AT 1.1.1.1\n"))
    end
  end

  context 'WITH conflicting nested attributes' do
    before do
      bob = chef_run.get_node('bob')
      bob.set['break']['search']['with']['chef_environment'] = 'production'
      bob.set['break']['search']['with']['ipaddress'] = '1.1.1.1'
      bob.save
      chef_run.converge(described_recipe)
    end

    it 'finds only "alice" when looking for production nodes' do
      is_expected.to render_file('/tmp/environment_search.txt')
        .with_content(eq("alice IN production\n"))
    end

    it 'finds only "alice" when looking for nodes with ip address "1.1.1.1"' do
      is_expected.to render_file('/tmp/ipaddress_search.txt')
        .with_content(eq("alice AT 1.1.1.1\n"))
    end
  end
end
