default['reserve_ip_in_range']['start_addr'] = '172.26.1.60'
default['reserve_ip_in_range']['end_addr'] = '172.26.1.65'
default['reserve_ip_in_range']['exclude'] = %w(172.26.1.1 172.26.1.2 172.26.1.3 172.26.1.4 172.26.1.5 172.26.1.6 172.26.1.7 172.26.1.8 172.26.1.9 172.26.1.10)
default['reserve_ip_in_range']['ptrdname'] = 'clogenyRange01.demo.com'
default['reserve_ip_in_range']['aliases'] = ['clogenyRange01']
default['reserve_ip_in_range']['record_type'] = %w(fixedaddress host A)
default['reserve_ip_in_range']['hostname'] = 'clogenyRange01.demo.com'
default['reserve_ip_in_range']['view'] = 'default'
default['reserve_ip_in_range']['disable'] = false
default['reserve_ip_in_range']['canonical'] = 'clogenyRange01.demo.com'
default['reserve_ip_in_range']['mac'] = ''
default['reserve_ip_in_range']['comment'] = 'Range VM'
default['reserve_ip_in_range']['extattrs'] = { 'Site' => { 'value' => 'Test Value' } }
