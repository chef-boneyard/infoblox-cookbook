# Cookbook Name: Infoblox
# Recipe Name: reserve_ip_in_range

include_recipe 'infoblox::default'

infoblox_next_available_ip_for_range "Find IP from Range" do
  start_addr node['reserve_ip_in_range']['start_addr']
  end_addr node['reserve_ip_in_range']['end_addr']
  exclude node['reserve_ip_in_range']['exclude']
  action :find
end

infoblox_ip_address "Reserve Range IP" do
  name node['reserve_ip_in_range']['hostname']
  record_type node['reserve_ip_in_range']['record_type']
  ptrdname node['reserve_ip_in_range']['ptrdname']
  ipv4addr node['reserve_ip_in_range']['ipv4addr']
  aliases node['reserve_ip_in_range']['aliases']
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
  hostname node['reserve_ip_in_range']['hostname']
  name node['reserve_ip_in_range']['vm_name']
  action :provision
end
