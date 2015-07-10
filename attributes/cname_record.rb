#
# Author:: Prabhu Das (<prabhu.das@clogeny.com>)
# Author:: Ramesh Sencha (<ramesh.sencha@clogeny.com>)
# Copyright:: Infoblox
# Maintainer:: Infoblox
# License:: Apache License, Version 2.0
#
default['cname_record']['name'] = 'clogeny01.demo.com'  # name of record in FQDN format eg. clogeny01.test.local
default['cname_record']['canonical'] = 'clogeny01-canonical.demo.com' # cannonical name in FQDN foramt. eg. clogeny.test.local
default['cname_record']['extattrs'] = { 'Site' => { 'value' => 'Test Value' } } # extensible attributes associated with the object. eg. { 'Site' => { 'value' => 'Test Value' } }
default['cname_record']['comment'] = 'Test AAAA Record' # comment for record in string format.
default['cname_record']['disable'] = false
default['cname_record']['view'] = 'default'
