#
# Author:: Prabhu Das (<prabhu.das@clogeny.com>)
# Author:: Ramesh Sencha (<ramesh.sencha@clogeny.com>)
# Copyright:: Infoblox
# Maintainer:: Infoblox
# License:: Apache License, Version 2.0
#
default['ptr_record']['name'] = 'clogeny01.demo.com' # name of record in FQDN format eg. clogeny01.test.local
default['ptr_record']['ipv4addr'] = '172.26.1.23' # IPv4 address eg. 10.10.70.100
default['ptr_record']['view'] = 'default' # name of DNS view in which record resides.
default['ptr_record']['ptrdname'] = 'clogeny.demo.com' # domain name of DNS PTR record in FQDN format. eg. clogeny.test.local
default['ptr_record']['extattrs'] = { 'Site' => { 'value' => 'Test Value' } } # extensible attributes associated with the object. eg. { 'Site' => { 'value' => 'Test Value' } }
default['ptr_record']['disable'] = false
default['ptr_record']['comment'] = 'Test PTR record'
