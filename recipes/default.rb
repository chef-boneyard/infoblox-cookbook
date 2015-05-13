#
# Cookbook Name:: infoblox
# Recipe:: default
#
# Copyright 2015, Clogeny Technologies
#
# All rights reserved - Do Not Redistribute
#

infoblox_ip_address 'Reserve static IP' do
  name node['ip_address']['hostname']
  ipv4addr node['ip_address']['ipv4addr']
  usage_type node['ip_address']['usage_type']
  mac node['ip_address']['mac']
  action :reserve_static_ip
end

# infoblox_ip_address 'Reserve IP in Network' do
#   network node['ip_address']['network']
#   usage_type 'host'
#   name node['ip_address']['hostname']
#   action :reserve_network_ip
# end
