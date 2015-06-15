default['reserve_ip_in_network']['network'] = '10.10.70.0/24'
default['reserve_ip_in_network']['exclude'] = %w(10.10.70.1 10.10.70.2 10.10.70.3)
default['reserve_ip_in_network']['ptrdname'] = 'clogeny01.test.local'
default['reserve_ip_in_network']['aliases'] = ['aliases1', 'aliases2']
default['reserve_ip_in_network']['record_type'] = %w(A PTR host fixedaddress)
default['reserve_ip_in_network']['hostname'] = 'clogeny100.test.local'
default['reserve_ip_in_network']['vm_name'] = 'clogeny100'
default['reserve_ip_in_network']['canonical'] = 'clogeny01.test.local'
default['reserve_ip_in_network']['comment'] = "Test Record for Reserve Static IP workflow"
default['reserve_ip_in_network']['extattrs'] = { 'Site' => { 'value' => 'Test Value' } }
default['reserve_ip_in_network']['mac'] = ''
