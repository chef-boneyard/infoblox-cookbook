# Cookbook Name: Infoblox
# Recipe Name: remove_aaaa_record

include_recipe "infoblox::default"

nfoblox_vm 'Power Off a VM' do
  user node['vcac_vm']['user']
  password node['vcac_vm']['password']
  host node['vcac_vm']['host']
  pubkey_hash node['vcac_vm']['pubkey_hash']
  name node['aaaa_record']['name']
  force node['vcac_vm']['force']
  notifies :deprovision, 'infoblox_vm[Deprovision a VM]'
  action :power_off
end

infoblox_vm 'Deprovision a VM' do
  user node['vcac_vm']['user']
  password node['vcac_vm']['password']
  host node['vcac_vm']['host']
  pubkey_hash node['vcac_vm']['pubkey_hash']
  name node['aaaa_record']['name']
  notifies :delete, 'infoblox_aaaa_record[Delete AAAA-record]', :immediately
end

infoblox_aaaa_record 'Delete AAAA-record' do
  ipv6addr node['aaaa_record']['ipv6addr']
  name node['aaaa_record']['vm_name']
  action :delete
end
