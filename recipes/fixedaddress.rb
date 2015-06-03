# Cookbook Name: Infoblox
# Recipe Name: fixedaddress

include_recipe "infoblox::default"

infoblox_fixedaddress 'Fixedaddress Create' do
  ipv4addr node['fixedaddress']['ipv4addr']
  name node['fixedaddress']['name']
  extattrs node['fixedaddress']['extattrs']
  action :create
end

infoblox_fixedaddress 'Get info for a Fixedaddress' do
  ipv4addr node['fixedaddress']['ipv4addr']
  action :get_info
end

infoblox_fixedaddress 'Fixedaddress Remove' do
  ipv4addr node['fixedaddress']['ipv4addr']
  mac node['fixedaddress']['mac']
  action :remove
end

infoblox_fixedaddress 'Create Fixedaddress in Network' do
  network node['fixedaddress']['network']
  mac node['fixedaddress']['mac']
  name node['fixedaddress']['name']
  extattrs node['fixedaddress']['extattrs']
  action :create_in_network
end
