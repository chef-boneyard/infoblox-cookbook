# Cookbook Name: Infoblox
# Recipe Name: remove_network

include_recipe "infoblox::default"

infoblox_network 'Delete Network' do
  network node['network']['subnet']
  action :delete
end
