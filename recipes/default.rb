#
# Cookbook Name:: infoblox
# Recipe:: default
#
# Copyright 2015, Clogeny Technologies
#
# All rights reserved - Do Not Redistribute
#

infoblox_ip_address "Reserve static IP" do
  name "clogeny.test.local"
  ipv4addr '10.10.70.36'
  usage_type 'host'
 # mac '00-0C-29-79-F7-5D'
  action :reserve_static_ip
end
