#
# Author:: Prabhu Das (<prabhu.das@clogeny.com>)
# Author:: Ramesh Sencha (<ramesh.sencha@clogeny.com>)
# Copyright:: Infoblox
# Maintainer:: Infoblox
# License:: Apache License, Version 2.0
#
default['a_record']['ipv4addr'] = '172.26.1.23' # IPv4 address eg. 10.10.70.15
default['a_record']['name'] = 'clogeny01.demo.com' # name of record in FQDN format eg. clogeny01.test.local
default['a_record']['record_ref'] = ''  # a_record ref'ZG5zLmJpbmRfYSQuX2RlZmF1bHQubG9jYWwudGVzdCxjbG9nZW55LDEwLjEwLjcwLjE:clogeny.test.local/default'
default['a_record']['extattrs'] = { 'Site' => { 'value' => 'Test Value' } } # extensible attributes associated with the object. eg. { 'Site' => { 'value' => 'Test Value' } }
default['a_record']['comment'] = 'Test A Record'
default['a_record']['disable'] = false
default['a_record']['view'] = 'default'
