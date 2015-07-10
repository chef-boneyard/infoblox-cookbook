#
# Author:: Prabhu Das (<prabhu.das@clogeny.com>)
# Author:: Ramesh Sencha (<ramesh.sencha@clogeny.com>)
# Copyright:: Infoblox
# Maintainer:: Infoblox
# License:: Apache License, Version 2.0
#
default['aaaa_record']['ipv6addr'] = 'FE80:0000:0000:0000:0202:B3FF:FE1E:839' # IPv6 address eg. FE80:0000:0000:0000:0202:B3FF
default['aaaa_record']['name'] = 'clogeny01.demo.com'  # name of record in FQDN format eg. clogeny01.test.local
default['aaaa_record']['extattrs'] = { 'Site' => { 'value' => 'Test Value' } } # extensible attributes associated with the object. eg. { 'Site' => { 'value' => 'Test Value' } }
default['aaaa_record']['comment'] = 'Test AAAA Record' # comment for record in string format.
default['aaaa_record']['disable'] = false
default['aaaa_record']['view'] = 'default'
