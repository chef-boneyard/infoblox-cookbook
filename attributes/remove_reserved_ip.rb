#
# Author:: Prabhu Das (<prabhu.das@clogeny.com>)
# Author:: Ramesh Sencha (<ramesh.sencha@clogeny.com>)
# Copyright:: Infoblox
# Maintainer:: Infoblox
# License:: Apache License, Version 2.0
#
default['remove_reserved_ip']['vm_name'] = 'rangeVM-2'
default['remove_reserved_ip']['ipv4addr'] = '172.26.1.45'
default['remove_reserved_ip']['ptrdname'] = 'clogeny042.demo.com'
default['remove_reserved_ip']['canonical'] = 'clogeny042.demo.com'
default['remove_reserved_ip']['record_type'] = %w(A PTR host fixedaddress)
