default['reserve_ip_in_range']['start_addr'] = '10.10.70.100'
default['reserve_ip_in_range']['end_addr'] = '10.10.70.220'
default['reserve_ip_in_range']['exclude'] = %w(10.10.70.100 10.10.70.101)
default['reserve_ip_in_range']['ptrdname'] = 'clogeny104.test.local'
default['reserve_ip_in_range']['aliases'] = ['clogeny104']
default['reserve_ip_in_range']['record_type'] = %w(fixedaddress host)
default['reserve_ip_in_range']['hostname'] = 'clogeny104.test.local'
default['reserve_ip_in_range']['zone'] = 'default'
default['reserve_ip_in_range']['view'] = 'default'
default['reserve_ip_in_range']['disable'] = false
default['reserve_ip_in_range']['vm_name'] = 'clogeny104'
default['reserve_ip_in_range']['canonical'] = 'chef_client104.test.local'
default['reserve_ip_in_range']['mac'] = ''
default['reserve_ip_in_range']['comment'] = 'Test Record for Reserve Static IP workflow'
default['reserve_ip_in_range']['extattrs'] = { 'Site' => { 'value' => 'Test Value' } }
