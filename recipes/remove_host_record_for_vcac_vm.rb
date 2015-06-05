# Cookbook Name: Infoblox
# Recipe Name: remove_host_record_for_vcac_vm

include_recipe "infoblox::default"

infoblox_vm 'Power Off a VM' do
  user node['vcac_vm']['user']
  password node['vcac_vm']['password']
  host node['vcac_vm']['host']
  pubkey_hash node['vcac_vm']['pubkey_hash']
  name node['deprovision_vcac_vm']['name']
  force node['vcac_vm']['force']
  notifies :deprovision, 'infoblox_vm[Deprovision a VM]'
  action :power_off
end

infoblox_vm 'Deprovision a VM' do
  user node['vcac_vm']['user']
  password node['vcac_vm']['password']
  host node['vcac_vm']['host']
  pubkey_hash node['vcac_vm']['pubkey_hash']
  name node['deprovision_vcac_vm']['name']
  notifies :delete, 'infoblox_host_record[Delete host-record]', :immediately
  action :deprovision
end

infoblox_host_record 'Delete host-record' do
  name node['deprovision_vcac_vm']['hostname']
  ipv4addr node['deprovision_vcac_vm']['ipv4addr']
  action :delete
end
