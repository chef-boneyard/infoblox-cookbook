default['reserve_ip_in_range']['start_addr'] = '10.10.70.100'
default['reserve_ip_in_range']['end_addr'] = '10.10.70.220'
default['reserve_ip_in_range']['exclude'] = %w(10.10.70.100 10.10.70.101)
default['reserve_ip_in_range']['ptrdname'] = 'clogeny01.test.local'
default['reserve_ip_in_range']['aliases'] = ['aliases1', 'aliases2']
default['reserve_ip_in_range']['record_type'] = %w(fixedaddress)
default['reserve_ip_in_range']['hostname'] = 'clogeny100.test.local'
default['reserve_ip_in_range']['vm_name'] = 'clogeny100'
default['reserve_ip_in_range']['canonical'] = 'clogeny01.test.local'
default['reserve_ip_in_range']['mac'] = "00:00:00:00:00:00"
default['reserve_ip_in_range']['comment'] = "Test Record for Reserve Static IP workflow"
default['reserve_ip_in_range']['extattrs'] = { 'Site' => { 'value' => 'Test Value' } }
