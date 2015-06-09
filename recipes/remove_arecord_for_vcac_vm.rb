# Cookbook Name: Infoblox
# Recipe Name: remove_arecord_for_vcac_vm

include_recipe "infoblox::default"

infoblox_vm 'Power Off a VM' do
  user node['vcac_vm']['user']
  password node['vcac_vm']['password']
  host node['vcac_vm']['host']
  pubkey_hash node['vcac_vm']['pubkey_hash']
  name node['a_record']['vm_name']
  force node['vcac_vm']['force']
  notifies :deprovision, 'infoblox_vm[Deprovision a VM]'
  action :power_off
end

infoblox_vm 'Deprovision a VM' do
  user node['vcac_vm']['user']
  password node['vcac_vm']['password']
  host node['vcac_vm']['host']
  pubkey_hash node['vcac_vm']['pubkey_hash']
  name node['a_record']['vm_name']
  notifies :delete, 'infoblox_a_record[Delete A-record]', :immediately
  action :deprovision
end

infoblox_a_record 'Delete A-record' do
  name node['a_record']['name']
  ipv4addr node['a_record']['ipv4addr']
  action :delete
end
