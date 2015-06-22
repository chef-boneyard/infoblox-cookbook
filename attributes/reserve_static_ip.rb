default['reserve_static_ip']['hostname'] = 'clogeny53.demo.com'
default['reserve_static_ip']['ipv4addr'] = '172.26.1.53'
default['reserve_static_ip']['ptrdname'] = 'clogeny53.demo.com'
default['reserve_static_ip']['aliases'] = ['aliases1', 'aliases2']
default['reserve_static_ip']['record_type'] = %w(A PTR host fixedaddress)
default['reserve_static_ip']['mac'] = ''
default['reserve_static_ip']['view'] = 'default'
default['reserve_static_ip']['disable'] = false
default['reserve_static_ip']['canonical'] = 'clogeny.demo.com'
default['reserve_static_ip']['comment'] = 'Test Record for Reserve Static IP workflow'
default['reserve_static_ip']['extattrs'] = { 'Site' => { 'value' => 'Test Value' } }
