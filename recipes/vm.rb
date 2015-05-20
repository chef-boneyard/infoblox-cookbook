infoblox_vm 'Provision a VM' do
  host node['vm']['host']
  user node['vm']['user']
  password node['vm']['password']
  name node['vm']['name']
  guest_id node['vm']['guest_id']
  datacenter node['vm']['datacenter']  
  num_cpus node['vm']['num_cpus']
  memory_mb node['vm']['memory_mb']
  disk_mode node['vm']['disk_mode']
  thin_provisioned node['vm']['thin_provisioned']
  datastore node['vm']['datastore']
  network node['vm']['network']
  action :provision
end

# infoblox_vm 'Power On a VM' do
#   user node['vm']['user']
#   password node['vm']['password']
#   host node['vm']['host']
#   datacenter node['vm']['datacenter']
#   name node['vm']['name']
#   action :power_on
# end

# infoblox_vm 'Power Off a VM' do
#   user node['vm']['user']
#   password node['vm']['password']
#   host node['vm']['host']
#   datacenter node['vm']['datacenter']
#   name node['vm']['name']
#   action :power_off
# end

# infoblox_vm 'Deprovision a VM' do
#   user node['vm']['user']
#   password node['vm']['password']
#   host node['vm']['host']
#   datacenter node['vm']['datacenter']
#   name node['vm']['name']
#   action :deprovision
# end
