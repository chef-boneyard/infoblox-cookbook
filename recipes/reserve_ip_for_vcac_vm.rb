# Cookbook Name: Infoblox
# Recipe Name: reserve_ip_for_vcac_vm

include_recipe "infoblox::default"

infoblox_ip_address 'Reserve static IP for host record' do
  name node['vcac_vm_static_ip']['hostname']
  ipv4addr node['vcac_vm_static_ip']['ipv4addr']
  extattrs node['vcac_vm_static_ip']['extattrs']
  comment node['vcac_vm_static_ip']['comment']
  usage_type node['vcac_vm_static_ip']['usage_type']
  record_type node['vcac_vm_static_ip']['record_type']
  action :reserve_static_ip
end

infoblox_vm 'Provision a aCAC VM with reserved IP' do
  host node['vcac_vm']['host']
  user node['vcac_vm']['user']
  password node['vcac_vm']['password']
  pubkey_hash node['vcac_vm']['pubkey_hash']
  template_path node['vcac_vm']['template_path']
  datacenter node['vcac_vm']['datacenter']
  datastore node['vcac_vm']['datastore']
  domain node['vcac_vm']['domain']
  gateway node['vcac_vm']['gateway']
  subnet_mask node['vcac_vm']['subnet_mask']
  hostname node['vcac_vm_static_ip']['hostname']
  name node['vcac_vm_static_ip']['name']
  ip node['vcac_vm_static_ip']['ipv4addr']
  action :provision
end
