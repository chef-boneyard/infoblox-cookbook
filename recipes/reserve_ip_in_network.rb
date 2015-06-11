# Cookbook Name: Infoblox
# Recipe Name: reserve_ip_in_network

include_recipe 'infoblox::default'

infoblox_next_available_ip_for_network "Find IP from Range" do  
  network node['reserve_ip_in_network']['network']
  exclude node['reserve_ip_in_network']['exclude']
  action :find
end

infoblox_ip_address "Reserve Network IP" do
  name node['reserve_ip_in_network']['hostname']
  record_type node['reserve_ip_in_network']['record_type']
  ptrdname node['reserve_ip_in_network']['ptrdname']
  aliases node['reserve_ip_in_network']['aliases']
  action :reserve
end

infoblox_vm 'Provision a aCAC VM with reserved IP' do
  host node['vcenter']['vcenter_host']
  user node['vcenter']['username']
  password node['vcenter']['password']
  pubkey_hash node['vcenter']['pubkey_hash']
  template_path node['vcenter']['template_path']
  datacenter node['vcenter']['datacenter']
  datastore node['vcenter']['datastore']
  domain node['vcenter']['domain']
  gateway node['vcenter']['gateway']
  subnet_mask node['vcenter']['subnet_mask']
  record_type %w(A PTR host fixedaddress)
  dns_server_list node['vcenter']['dns_server_list']
  network_adapter node['vcenter']['network_adapter']
  hostname node['reserve_ip_in_network']['hostname']
  name node['reserve_ip_in_network']['vm_name']
  action :provision
end

