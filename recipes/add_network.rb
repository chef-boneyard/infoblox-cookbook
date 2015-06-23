# Cookbook Name: Infoblox
# Recipe Name: add_network

include_recipe "infoblox::default"

infoblox_network 'Create Network' do
  network node['network']['subnet']
  network_view node['network']['network_view']
  extattrs node['network']['extattrs']
  comment node['network']['comment']
  action :create
end
