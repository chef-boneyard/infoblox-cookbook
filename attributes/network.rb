#
# Author:: Prabhu Das (<prabhu.das@clogeny.com>)
# Author:: Ramesh Sencha (<ramesh.sencha@clogeny.com>)
# Copyright:: Infoblox
# Maintainer:: Infoblox
# License:: Apache License, Version 2.0
#
# network attributes
default['network']['subnet'] = '172.26.2.0/24' # network address, in IPv4 address/CIDR foramt. eg. '10.10.70.0/24'
default['network']['network_view'] = 'default'
default['network']['extattrs'] = { 'Site' => { 'value' => 'Test Network' } } # extensible attributes associated with the object. eg. { 'Site' => { 'value' => 'Test Value' } }
default['network']['comment'] = "Test network"
default['network']['network_ref'] = '' # valid network object reference EX: ZG5zLm5ldHdvcmskMTAuMTAuNzAuMC8yNC8w:10.10.70.0/24/default.
