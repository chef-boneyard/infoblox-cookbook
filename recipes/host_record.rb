# Cookbook Name: Infoblox
# Recipe Name: host_record

include_recipe "infoblox::default"

infoblox_host_record 'Host record create' do
  ipv4addr node['host_record']['ipv4addr']
  name node['host_record']['name']
  extattrs node['host_record']['extattrs']
  comment node['host_record']['comment']
  disable node['host_record']['disable']
  action :create
end

infoblox_host_record 'Host record remove' do
  ipv4addr node['host_record']['ipv4addr']
  name node['host_record']['name']
  action :remove
end
