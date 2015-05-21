infoblox_vm 'Provision a VM' do
  host node['vm']['host']
  user node['vm']['user']
  password node['vm']['password']
  pubkey_hash node['vm']['pubkey_hash']
  template_path node['vm']['template_path']
  datacenter node['vm']['datacenter']
  datastore node['vm']['datastore']
  hostname node['vm']['hostname']
  name node['vm']['name']
  domain node['vm']['domain']
  ip node['vm']['ip']
  gateway node['vm']['gateway']
  subnet_mask node['vm']['subnet_mask']
  action :provision
end

infoblox_vm 'Power On a VM' do
  user node['vm']['user']
  password node['vm']['password']
  host node['vm']['host']
  pubkey_hash node['vm']['pubkey_hash']
  instance_uuid node['vm']['instance_uuid']
  action :power_on
end

infoblox_vm 'Power Off a VM' do
  user node['vm']['user']
  password node['vm']['password']
  host node['vm']['host']
  pubkey_hash node['vm']['pubkey_hash']
  instance_uuid node['vm']['instance_uuid']
  action :power_off
end

infoblox_vm 'Deprovision a VM' do
  user node['vm']['user']
  password node['vm']['password']
  host node['vm']['host']
  pubkey_hash node['vm']['pubkey_hash']
  instance_uuid node['vm']['instance_uuid']
  action :deprovision
end
