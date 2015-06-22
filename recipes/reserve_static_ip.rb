# Cookbook Name: Infoblox
# Recipe Name: reserve_static_ip

include_recipe "infoblox::default"

infoblox_ip_address "Reserve static IP" do
  name node['reserve_static_ip']['hostname']
  ipv4addr node['reserve_static_ip']['ipv4addr']
  record_type node['reserve_static_ip']['record_type']
  ptrdname node['reserve_static_ip']['ptrdname']
  aliases node['reserve_static_ip']['aliases']
  canonical node['reserve_static_ip']['canonical'] 
  extattrs node['reserve_static_ip']['extattrs']
  comment node['reserve_static_ip']['comment']
  view node['reserve_static_ip']['view']
  disable node['reserve_static_ip']['disable']
  action :reserve
end

include_recipe "infoblox::vm_provision"
