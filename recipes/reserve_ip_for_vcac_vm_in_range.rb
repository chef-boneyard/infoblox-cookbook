# Cookbook Name: Infoblox
# Recipe Name: reserve_ip_for_vcac_vm_in_range

include_recipe "infoblox::default"

infoblox_range 'Reserve IP in range' do
  name node['vcac_vm_range_ip']['hostname']
  start_addr node['vcac_vm_range_ip']['start_addr']
  end_addr node['vcac_vm_range_ip']['end_addr']
  extattrs node['vcac_vm_range_ip']['extattrs']
  comment node['vcac_vm_range_ip']['comment']
  exclude node['vcac_vm_range_ip']['exclude']
  usage_type node['vcac_vm_range_ip']['usage_type']
  record_type node['vcac_vm_range_ip']['record_type']
  action :reserve_ip
end

infoblox_vm 'Provision a VM' do
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
  hostname node['vcac_vm_range_ip']['hostname']
  name node['vcac_vm_range_ip']['name']
  action :provision
end
