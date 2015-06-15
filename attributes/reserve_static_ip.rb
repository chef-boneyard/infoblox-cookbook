default['reserve_static_ip']['hostname'] = 'clogeny52.qa.com'
default['reserve_static_ip']['ipv4addr'] = '172.26.1.52'
default['reserve_static_ip']['vm_name'] = 'clogeny52qa' # required for reserve and remove workflows
default['reserve_static_ip']['ptrdname'] = 'clogeny52.test.local'
default['reserve_static_ip']['aliases'] = ['aliases1', 'aliases2']
default['reserve_static_ip']['record_type'] = ['host']  # or %w(A PTR host fixedaddress)

default['reserve_static_ip']['mac'] = ''
default['reserve_static_ip']['canonical'] = 'clogeny52.qa.com'
default['reserve_static_ip']['comment'] = "Test Record for Reserve Static IP workflow"
default['reserve_static_ip']['extattrs'] = { 'Site' => { 'value' => 'Test Value' } }