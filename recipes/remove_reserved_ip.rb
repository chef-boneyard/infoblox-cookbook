# Cookbook Name: Infoblox
# Recipe Name: remove_reserved_ip

include_recipe 'infoblox::default'

include_recipe "infoblox::vm_deprovision"

infoblox_ip_address "Remove reserved IP" do
  name node['remove_reserved_ip']['hostname']
  ipv4addr node['remove_reserved_ip']['ipv4addr']
  record_type node['remove_reserved_ip']['record_type']
  ptrdname node['remove_reserved_ip']['ptrdname']
  canonical node['remove_reserved_ip']['canonical']
  action :remove
end