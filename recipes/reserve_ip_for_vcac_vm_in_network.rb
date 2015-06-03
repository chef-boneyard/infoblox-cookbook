# Cookbook Name: Infoblox
# Recipe Name: reserve_ip_for_vcac_vm_in_network

infoblox_ip_address 'Reserve static IP for host record' do
  name node['vcac_vm_network_ip']['hostname']
  extattrs node['vcac_vm_network_ip']['extattrs']
  comment node['vcac_vm_network_ip']['comment']
  network node['vcac_vm_network_ip']['network']
  exclude node['vcac_vm_network_ip']['exclude']
  usage_type node['vcac_vm_network_ip']['usage_type']
  record_type node['vcac_vm_network_ip']['record_type']
  action :reserve_network_ip
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
  hostname node['vcac_vm_network_ip']['hostname']
  name node['vcac_vm_network_ip']['name']
  action :provision
end
