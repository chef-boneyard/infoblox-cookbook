# vcenter vm provision details
default['vcenter']['template_name'] = 'IB-Ubuntu-Chef-Server-02'
default['vcenter']['datacenter'] = 'IB'
default['vcenter']['datastore'] = 'datastore1'
default['vcenter']['domain'] = 'demo.com'
default['vcenter']['network_name'] = ["VM Network"]
default['vcenter']['gateway'] = ['172.26.1.1']
default['vcenter']['subnet_mask'] = '255.255.255.0'
default['vcenter']['dns_server_list'] = ['172.26.1.2']
default['vcenter']['network_adapter'] = 'Network adapter 1'
default['vcenter']['resource_pool'] = '172.26.1.4'

# provisioned VM details
default['vcenter']['vm']['username'] = 'root'
default['vcenter']['vm']['password'] = 'infoblox'
default['vcenter']['vm']['num_cpus'] = 2
default['vcenter']['vm']['memory_mb'] = 1024
# vm name should be letters, numbers or hyphens in hostnames allowed eg. my-host01
default['vcenter']['vm']['name'] = 'clogenyNetwork01'
# override this attributes for next available ip in range and network.
default['vcenter']['vm']['ip'] = nil
