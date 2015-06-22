# Cookbook Name: Infoblox
# Recipe Name: default

chef_gem 'chef-provisioning-vsphere' do
  compile_time true
  version '0.5.7'
  action :install
end

chef_gem 'infoblox' do
  compile_time true
  version '0.4.1'
  action :install
end

require 'infoblox'
