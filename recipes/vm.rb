infoblox_vm 'Provision a VM' do
  host node['vcac_vm']['host']
  user node['vcac_vm']['user']
  password node['vcac_vm']['password']
  pubkey_hash node['vcac_vm']['pubkey_hash']
  template_path node['vcac_vm']['template_path']
  datacenter node['vcac_vm']['datacenter']
  datastore node['vcac_vm']['datastore']
  hostname node['vcac_vm']['hostname']
  name node['vcac_vm']['name']
  domain node['vcac_vm']['domain']
  ip node['vcac_vm']['ip']
  gateway node['vcac_vm']['gateway']
  subnet_mask node['vcac_vm']['subnet_mask']
  action :provision
end

infoblox_vm 'Power On a VM' do
  user node['vcac_vm']['user']
  password node['vcac_vm']['password']
  host node['vcac_vm']['host']
  pubkey_hash node['vcac_vm']['pubkey_hash']
  name node['vcac_vm']['name']
  action :power_on
end

infoblox_vm 'Power Off a VM' do
  user node['vcac_vm']['user']
  password node['vcac_vm']['password']
  host node['vcac_vm']['host']
  pubkey_hash node['vcac_vm']['pubkey_hash']
  name node['vcac_vm']['name']
  force node['vcac_vm']['force']
  action :power_off
end

infoblox_vm 'Deprovision a VM' do
  user node['vcac_vm']['user']
  password node['vcac_vm']['password']
  host node['vcac_vm']['host']
  pubkey_hash node['vcac_vm']['pubkey_hash']
  name node['vcac_vm']['name']
  action :deprovision
end
