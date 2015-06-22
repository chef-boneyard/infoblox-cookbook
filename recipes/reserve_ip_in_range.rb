# Cookbook Name: Infoblox
# Recipe Name: reserve_ip_in_range

include_recipe 'infoblox::default'

extend Infoblox::Api
next_available_ip = self.get_next_ip_from_range( node['reserve_ip_in_range']['start_addr'], node['reserve_ip_in_range']['end_addr'], node['reserve_ip_in_range']['exclude'] )
node.set['vcenter']['vm']['ipaddress'] = next_available_ip
node.set['vcenter']['vm']['name'] = node['reserve_ip_in_range']['vm_name']

if next_available_ip

  infoblox_ip_address "Reserve IP in Range" do
    name node['reserve_ip_in_range']['vm_name'] + '.' + node['vcenter']['domain']
    record_type node['reserve_ip_in_range']['record_type']
    ptrdname node['reserve_ip_in_range']['ptrdname']
    aliases node['reserve_ip_in_range']['aliases']
    canonical node['reserve_ip_in_range']['canonical'] 
    extattrs node['reserve_ip_in_range']['extattrs']
    comment node['reserve_ip_in_range']['comment']
    view node['reserve_ip_in_range']['view']
    disable node['reserve_ip_in_range']['disable']
    action :reserve
  end

  include_recipe "infoblox::vm_provision"

end