default['ip_address']['name'] = '' # name of record in FQDN format eg. clogeny01.test.local
default['ip_address']['ipv4addr'] = '' # IPv4 address
default['ip_address']['mac'] = '' # MAC address eg. '00-0C-29-79-F7-5A'
default['ip_address']['network'] = '' # network address, in IPv4 address/CIDR foramt. eg. '10.10.70.0/24'
default['ip_address']['exclude'] = [] # array of ip addresses eg. %w(10.10.70.100 10.10.70.107)
default['ip_address']['extattrs'] = {} # extensible attributes associated with the object. eg. { 'Site' => { 'value' => 'Test Value' } }
default['ip_address']['ptrdname'] = '' # domain name of DNS PTR record in FQDN format. eg. clogeny.test.local
default['ip_address']['canonical'] = '' # cannonical name in FQDN foramt. eg. clogeny.test.local
default['ip_address']['usage_type'] = 'host' # either of follwoing dns, host, fixed_address
default['ip_address']['record_type'] = 'A' # either of following A, AAAA, PTR, CNAME
default['ip_address']['comment'] = '' # comment for record in string format.
default['ip_address']['aliases'] = [] # list of aliases of host in FQDN format.
