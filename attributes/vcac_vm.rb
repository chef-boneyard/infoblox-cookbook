# Reserve static IP
default['vcac_vm_static_ip']['name'] = 'clogeny02'
default['vcac_vm_static_ip']['ipv4addr'] = '10.10.70.2'
default['vcac_vm_static_ip']['hostname'] = 'clogeny02.test.local'
default['vcac_vm_static_ip']['mac'] = ''
default['vcac_vm_static_ip']['ptrdname'] = ''
default['vcac_vm_static_ip']['canonical'] = ''
default['vcac_vm_static_ip']['extattrs'] = { 'Site' => { 'value' => 'Test Value' } }
default['vcac_vm_static_ip']['comment'] = 'Test record for reserve static IP'
default['vcac_vm_static_ip']['usage_type'] = 'dns'
default['vcac_vm_static_ip']['record_type'] = 'A'

# Reserve IP in network
default['vcac_vm_network_ip']['name'] = 'clogeny03'
default['vcac_vm_network_ip']['hostname'] = 'clogeny03.test.local'
default['vcac_vm_network_ip']['mac'] = ''
default['vcac_vm_network_ip']['network'] = '10.10.70.0/24'
default['vcac_vm_network_ip']['exclude'] = %w(10.10.70.1 10.10.70.2)
default['vcac_vm_network_ip']['ptrdname'] = ''
default['vcac_vm_network_ip']['canonical'] = ''
default['vcac_vm_network_ip']['extattrs'] = { 'Site' => { 'value' => 'Test Value' } }
default['vcac_vm_network_ip']['comment'] = 'Test Record for resere IP in network'
default['vcac_vm_network_ip']['usage_type'] = 'dns'
default['vcac_vm_network_ip']['record_type'] = 'A'

# Reserve IP in range
default['vcac_vm_range_ip']['name'] = 'clogeny04'
default['vcac_vm_range_ip']['hostname'] = 'clogeny04.test.local'
default['vcac_vm_range_ip']['mac'] = ''
default['vcac_vm_range_ip']['start_addr'] = '10.10.70.100'
default['vcac_vm_range_ip']['end_addr'] = '10.10.70.220'
default['vcac_vm_range_ip']['exclude'] = %w(10.10.70.100 10.10.70.102)
default['vcac_vm_range_ip']['ptrdname'] = ''
default['vcac_vm_range_ip']['canonical'] = ''
default['vcac_vm_range_ip']['extattrs'] = { 'Site' => { 'value' => 'Test Value' } }
default['vcac_vm_range_ip']['comment'] = 'Test Record for reserve IP in range'
default['vcac_vm_range_ip']['usage_type'] = 'dns'
default['vcac_vm_range_ip']['record_type'] = 'A'
