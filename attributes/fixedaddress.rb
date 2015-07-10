#
# Author:: Prabhu Das (<prabhu.das@clogeny.com>)
# Author:: Ramesh Sencha (<ramesh.sencha@clogeny.com>)
# Copyright:: Infoblox
# Maintainer:: Infoblox
# License:: Apache License, Version 2.0
#
default['fixedaddress']['ipv4addr'] = '172.26.1.23' # IPv4 address eg. 10.10.70.100
default['fixedaddress']['mac'] =  '' # MAC address eg. '00-0C-29-79-F7-5A'
default['fixedaddress']['name'] = 'clogeny01.demo.com'  # name of record in FQDN format eg. clogeny01.test.local
default['fixedaddress']['network'] = '172.26.1.0/24' # network address, in IPv4 address/CIDR foramt. eg. '10.10.70.0/24'
default['fixedaddress']['network_view'] = ''
default['fixedaddress']['extattrs'] = { 'Site' => { 'value' => 'Test Value' } } # extensible attributes associated with the object. eg. { 'Site' => { 'value' => 'Test Value' } }
default['fixedaddress']['comment'] = 'Test fixedaddress record'
