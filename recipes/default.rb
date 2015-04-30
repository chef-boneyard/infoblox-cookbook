#
# Cookbook Name:: infoblox
# Recipe:: default
#
# Copyright 2015, Clogeny Technologies
#
# All rights reserved - Do Not Redistribute
#

#infoblox_ip_address "Reserve static IP" do
#  name "clogeny.test.local"
#  ipv4addr '10.10.70.36'
#  usage_type 'host'
 # mac '00-0C-29-79-F7-5D'
#  action :reserve_static_ip
#end

a_record "Delete A Record" do
  _ref "record:a/ZG5zLmJpbmRfYSQuX2RlZmF1bHQubG9jYWwudGVzdCxjbG9nZW55NCwxMC4xMC43MC4zNA:clogeny4.test.local/default" 
  action :delete
end
