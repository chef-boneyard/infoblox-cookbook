# Reserve static IP
default['vcac_vm_static_ip']['name'] = 'clogeny02'
default['vcac_vm_static_ip']['ipv4addr'] = '10.10.70.2'
default['vcac_vm_static_ip']['hostname'] = 'clogeny02.poc.infobloxdemo.com'
default['vcac_vm_static_ip']['mac'] = ''
default['vcac_vm_static_ip']['ptrdname'] = ''
default['vcac_vm_static_ip']['canonical'] = ''
default['vcac_vm_static_ip']['extattrs'] = { 'Site' => { 'value' => 'Test Value' } }
default['vcac_vm_static_ip']['comment'] = 'Test record for reserve static IP'
default['vcac_vm_static_ip']['usage_type'] = 'dns'
default['vcac_vm_static_ip']['record_type'] = 'A'

# Reserve IP in network
default['vcac_vm_network_ip']['name'] = 'clogeny12'
default['vcac_vm_network_ip']['hostname'] = 'clogeny12.demo.com'
default['vcac_vm_network_ip']['mac'] = ''
default['vcac_vm_network_ip']['network'] = '172.26.1.0/24'
default['vcac_vm_network_ip']['exclude'] = %w(10.10.70.1 10.10.70.2)
default['vcac_vm_network_ip']['ptrdname'] = ''
default['vcac_vm_network_ip']['canonical'] = ''
default['vcac_vm_network_ip']['extattrs'] = { 'Site' => { 'value' => 'Test Value' } }
default['vcac_vm_network_ip']['comment'] = 'Test Record for resere IP in network'
default['vcac_vm_network_ip']['usage_type'] = 'host'
default['vcac_vm_network_ip']['record_type'] = 'A'
default['vcac_vm_network_ip']['network_adapter'] = 'Network adapter 1'

# Reserve IP in range
default['vcac_vm_range_ip']['name'] = 'clogeny13'
default['vcac_vm_range_ip']['hostname'] = 'clogeny13.poc.infobloxdemo.com'
default['vcac_vm_range_ip']['mac'] = ''
default['vcac_vm_range_ip']['start_addr'] = '172.26.1.1'
default['vcac_vm_range_ip']['end_addr'] = '172.26.1.60'
default['vcac_vm_range_ip']['exclude'] = %w(172.26.1.1 172.26.1.2)
default['vcac_vm_range_ip']['ptrdname'] = ''
default['vcac_vm_range_ip']['canonical'] = ''
default['vcac_vm_range_ip']['extattrs'] = { 'Site' => { 'value' => 'Test Value' } }
default['vcac_vm_range_ip']['comment'] = 'Test Record for reserve IP in range'
default['vcac_vm_range_ip']['usage_type'] = 'dns'
default['vcac_vm_range_ip']['record_type'] = 'A'

# Remove Host Machine/record
default['deprovision_vcac_vm']['name'] = 'clogeny12'
default['deprovision_vcac_vm']['hostname'] = 'clogeny12.demo.com'
default['deprovision_vcac_vm']['ipv4addr'] = '172.26.1.67'
