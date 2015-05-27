# Cookbook Name: Infoblox
# Recipe Name: remove_network

infoblox_network 'Delete Network' do
  network node['network']['subnet']
  action :delete
end
