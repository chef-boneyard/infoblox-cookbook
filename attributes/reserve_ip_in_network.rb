default['reserve_ip_in_network']['network'] = '172.26.1.0/24'
default['reserve_ip_in_network']['exclude'] = %w(172.26.1.1 172.26.1.2 172.26.1.3 172.26.1.4 172.26.1.5 172.26.1.6 172.26.1.7 172.26.1.8 172.26.1.9 172.26.1.10)
default['reserve_ip_in_network']['ptrdname'] = 'clogenyNetwork01.demo.com'
default['reserve_ip_in_network']['aliases'] = ['aliases1', 'aliases2']
default['reserve_ip_in_network']['record_type'] = %w(A PTR host fixedaddress)
default['reserve_ip_in_network']['hostname'] = 'clogenyNetwork01.demo.com'
default['reserve_ip_in_network']['canonical'] = 'clogenyNetwork01.demo.com'
default['reserve_ip_in_network']['mac'] = ''
default['reserve_ip_in_range']['view'] = 'default'
default['reserve_ip_in_range']['disable'] = false
default['reserve_ip_in_network']['comment'] = 'Test Record for Reserve Static IP workflow'
default['reserve_ip_in_network']['extattrs'] = { 'Site' => { 'value' => 'Test Value' } }
