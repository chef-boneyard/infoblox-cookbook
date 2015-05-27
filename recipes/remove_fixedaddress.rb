# Cookbook Name: Infoblox
# Recipe Name: remove_fixedaddress

infoblox_fixedaddress 'Remove Fixedaddress' do
  ipv4addr node['fixedaddress']['ipv4addr']
  action :remove
end

infoblox_vm 'Power Off a VM' do
  user node['vcac_vm']['user']
  password node['vcac_vm']['password']
  host node['vcac_vm']['host']
  pubkey_hash node['vcac_vm']['pubkey_hash']
  force node['vcac_vm']['force']
  name node['fixedaddress']['name']
  action :power_off
end

infoblox_vm 'Deprovision a VM' do
  user node['vcac_vm']['user']
  password node['vcac_vm']['password']
  host node['vcac_vm']['host']
  pubkey_hash node['vcac_vm']['pubkey_hash']
  name node['fixedaddress']['name']
  action :deprovision
end
