# Cookbook Name: Infoblox
# Recipe Name: remove_reserve_address

include_recipe "infoblox::default"

infoblox_fixedaddress 'Remove Reserve address' do
  ipv4addr node['fixedaddress']['ipv4addr']
  action :delete
end
