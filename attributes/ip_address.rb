default['ip_address']['name'] = 'clogeny01.test.local'
default['ip_address']['ipv4addr'] = '10.10.70.1'
default['ip_address']['mac'] = '00-0C-29-79-F7-5A'
default['ip_address']['network'] = '10.10.70.0/24'
default['ip_address']['extattrs'] = { 'Site' => 'Bye' }
default['ip_address']['exclude'] = %w(10.10.70.101 10.10.70.107 10.10.70.108 10.10.70.104)
default['ip_address']['extattrs'] = { 'Site' => { 'value' => 'Test Value' } }
default['ip_address']['ptrdname'] = 'clogeny_ptr'
default['ip_address']['canonical'] = 'clogeny1'
default['ip_address']['usage_type'] = 'dns'
default['ip_address']['record_type'] = 'PTR'
default['ip_address']['comment'] = 'Test Comment for record'
