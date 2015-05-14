# Cookbook Name: Infoblox
# Recipe Name: network_ip_address

infoblox_ip_address 'Reserve IP in Network' do
  network node['ip_address']['network']
  usage_type 'host'
  name node['ip_address']['hostname']
  action :reserve_network_ip
end

infoblox_ip_address 'Reserve IP in Network' do
  network node['ip_address']['network']
  usage_type 'dns'
  name node['ip_address']['hostname']
  action :reserve_network_ip
end
