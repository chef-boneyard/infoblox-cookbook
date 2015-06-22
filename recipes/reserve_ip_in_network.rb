# Cookbook Name: Infoblox
# Recipe Name: reserve_ip_in_network

include_recipe 'infoblox::default'

extend Infoblox::Api
next_available_ip = self.get_next_ip_from_network( node['reserve_ip_in_network']['network'], node['reserve_ip_in_network']['exclude'] )
node.set['vcenter']['vm']['ipaddress'] = next_available_ip
node.set['vcenter']['vm']['name'] = node['reserve_ip_in_network']['vm_name']

if next_available_ip

  infoblox_ip_address "Reserve Network IP" do
    name node['reserve_ip_in_network']['vm_name'] + '.' + node['vcenter']['domain']
    record_type node['reserve_ip_in_network']['record_type']
    ptrdname node['reserve_ip_in_network']['ptrdname']
    aliases node['reserve_ip_in_network']['aliases']
    canonical node['reserve_ip_in_network']['canonical'] 
    extattrs node['reserve_ip_in_network']['extattrs']
    comment node['reserve_ip_in_network']['comment']
    view node['reserve_ip_in_network']['view']
    disable node['reserve_ip_in_network']['disable']
    action :reserve
  end

  include_recipe "infoblox::vm_provision"

end
