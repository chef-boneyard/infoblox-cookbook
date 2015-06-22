# Cookbook Name: Infoblox
# Recipe Name: remove_reserved_ip

include_recipe 'infoblox::default'
node.set['vcenter']['vm']['name'] = node['remove_reserved_ip']['vm_name']

include_recipe "infoblox::vm_deprovision"

infoblox_ip_address "Remove reserved IP" do
  name node['remove_reserved_ip']['vm_name'] + '.' + node['vcenter']['domain']
  ipv4addr node['remove_reserved_ip']['ipv4addr']
  record_type node['remove_reserved_ip']['record_type']
  ptrdname node['remove_reserved_ip']['ptrdname']
  canonical node['remove_reserved_ip']['canonical']
  action :remove
end