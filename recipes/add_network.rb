# Cookbook Name: Infoblox
# Recipe Name: add_network

infoblox_network 'Create Network' do
  network node['network']['subnet']
  extattrs node['network']['extattrs']
  action :create
end
