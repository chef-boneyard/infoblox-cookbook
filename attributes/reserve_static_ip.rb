default['reserve_static_ip']['ipv4addr'] = '10.10.70.100'
default['reserve_static_ip']['ptrdname'] = 'clogeny01.test.local'
default['reserve_static_ip']['aliases'] = ['aliases1', 'aliases2']
default['reserve_static_ip']['record_type'] = %w(A PTR host fixedaddress)
default['reserve_static_ip']['hostname'] = 'clogeny100.test.local'
default['reserve_static_ip']['vm_name'] = 'clogeny100'
default['reserve_static_ip']['canonical'] = 'clogeny01.test.local'
default['reserve_static_ip']['comment'] = "Test Record for Reserve Static IP workflow"
default['reserve_static_ip']['extattrs'] = { 'Site' => { 'value' => 'Test Value' } }
