#
# Cookbook Name:: infoblox
# Recipe:: default
#
# Copyright 2015, Clogeny Technologies
#
# All rights reserved - Do Not Redistribute
#

infoblox_ip_address "Reserve static IP" do
  name "clogeny3.test.local"
  ipv4addr '10.10.70.34'
  usage_type 'host'
  # mac_address 'ff.ff.ff.ff.ff.ff'
  action :reserve_static_ip
end