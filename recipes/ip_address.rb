# Cookbook Name: Infoblox
# Recipe Name: ip_address

include_recipe "infoblox::default"

infoblox_ip_address 'Reserve static IP for host record' do
  name "clogeny01.test.local"
  ptrdname node['ip_address']['ptrdname']
  ipv4addr node['ip_address']['ipv4addr']
  extattrs node['ip_address']['extattrs']
  canonical node['ip_address']['ptrdname']
  comment node['ip_address']['comment']
  usage_type node['ip_address']['usage_type']
  record_type node['ip_address']['record_type']
  action :reserve_static_ip
end

infoblox_ip_address 'Reserve static IP for DNS record' do
  name node['ip_address']['name']
  network node['ip_address']['network']
  exclude node['ip_address']['exclude']
  ptrdname node['ip_address']['ptrdname']
  extattrs node['ip_address']['extattrs']
  usage_type node['ip_address']['usage_type']
  record_type node['ip_address']['record_type']
  action :reserve_network_ip
end
