# Cookbook Name: Infoblox
# Recipe Name: range

include_recipe "infoblox::default"

infoblox_range 'Reserve IP for fixed address record in range' do
  start_addr node['range']['start_addr']
  end_addr node['range']['end_addr']
  exclude node['range']['exclude']
  usage_type node['range']['usage_type']
  mac node['range']['mac']
  network node['range']['network']
  extattrs node['range']['extattrs']
  name node['range']['name']
  canonical node['range']['canonical']
  ptrdname node['range']['ptrdname']
  record_type node['range']['record_type']
  action :reserve_ip
end
