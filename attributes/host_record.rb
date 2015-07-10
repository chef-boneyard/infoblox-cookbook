#
# Author:: Prabhu Das (<prabhu.das@clogeny.com>)
# Author:: Ramesh Sencha (<ramesh.sencha@clogeny.com>)
# Copyright:: Infoblox
# Maintainer:: Infoblox
# License:: Apache License, Version 2.0
#
default['host_record']['ipv4addr'] = '172.26.1.23' # IPv4 address eg. 10.10.70.100
default['host_record']['mac'] =  '00-0C-29-79-F7-5A' # MAC address eg. '00-0C-29-79-F7-5A'
default['host_record']['name'] = 'clogeny01.demo.com'  # name of record in FQDN format eg. clogeny01.test.local
default['host_record']['disable'] = false
default['host_record']['view'] = 'default'
default['host_record']['extattrs'] = { 'Site' => { 'value' => 'Test Value' } } # extensible attributes associated with the object. eg. { 'Site' => { 'value' => 'Test Value' } }
default['host_record']['comment'] = 'Test host record'
default['host_record']['aliases'] = ['test']
