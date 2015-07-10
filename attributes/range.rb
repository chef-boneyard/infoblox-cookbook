#
# Author:: Prabhu Das (<prabhu.das@clogeny.com>)
# Author:: Ramesh Sencha (<ramesh.sencha@clogeny.com>)
# Copyright:: Infoblox
# Maintainer:: Infoblox
# License:: Apache License, Version 2.0
#
default['range']['name'] = '' # name of record in FQDN format eg. clogeny01.test.local
default['range']['start_addr'] = '' # IPv4 address eg. 10.10.70.100
default['range']['end_addr'] = '' # IPv4 address eg. 10.10.70.220
default['range']['exclude'] =  ['172.26.1.1', '172.26.1.2', '172.26.1.5', '172.26.1.9', '172.26.1.11', '172.26.1.5', '172.26.1.50', '172.26.1.51', '172.26.1.53', '172.26.1.61', '172.26.1.151' ] # should be array of ip addresses eg. [ '10.10.70.100', '10.10.70.107' ]
default['range']['num'] = 5
default['range']['usage_type'] = 'host' # either of follwoing dns, host, fixed_address
default['range']['mac'] = '' # MAC address eg. '00-0C-29-79-F7-5A'
default['range']['network'] = '' # network address, in IPv4 address/CIDR foramt. eg. '10.10.70.0/24'
default['range']['extattrs'] = {} # extensible attributes associated with the object. eg. { 'Site' => { 'value' => 'Test Value' } }
default['range']['comment'] = '' # comment for record in string format.
default['range']['ptrdname'] = '' # domain name of DNS PTR record in FQDN format. eg. clogeny.test.local
default['range']['canonical'] = '' # cannonical name in FQDN foramt. eg. clogeny.test.local
default['range']['record_type'] = 'A' # either of following A, AAAA, PTR, CNAME
