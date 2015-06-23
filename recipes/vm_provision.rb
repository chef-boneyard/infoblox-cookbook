# Cookbook Name: Infoblox
# Recipe Name: vm_provision

require 'chef/provisioning/vsphere_driver'

with_vsphere_driver host: node['vcenter']['vcenter_host'],
  insecure: node['vcenter']['insecure'],
  user:     node['vcenter']['username'],
  password: node['vcenter']['password']

with_machine_options :bootstrap_options => {
  num_cpus: node['vcenter']['vm']['num_cpus'],
  memory_mb: node['vcenter']['vm']['memory_mb'],
  network_name: node['vcenter']['network_name'],
  datacenter: node['vcenter']['datacenter'],
  datastore: node['vcenter']['datastore'],
  resource_pool: node['vcenter']['resource_pool'],
  template_name: node['vcenter']['template_name'],
  customization_spec: {
    ipsettings: {
      ip: node['vcenter']['vm']['ipaddress'] || node['reserve_static_ip']['ipv4addr'],
      dnsServerList: node['vcenter']['dns_server_list'],
      subnetMask: node['vcenter']['subnet_mask'],
      gateway: node['vcenter']['gateway']
    },
    :domain => node['vcenter']['domain']
  },
  :ssh => {
    :user => node['vcenter']['vm']['username'],
    :password => node['vcenter']['vm']['password'],
    :paranoid => false,
  }
}, :convergence_options => {
  ssl_verify_mode: :verify_none
}

machine node['vcenter']['vm']['name'] do
end
