#
# Author:: Prabhu Das (<prabhu.das@clogeny.com>)
# Author:: Ramesh Sencha (<ramesh.sencha@clogeny.com>)
# Copyright:: Infoblox
# Maintainer:: Infoblox
# License:: Apache License, Version 2.0
#
default['reserve_static_ip']['vm_name'] = 'staticVM-1'
default['reserve_static_ip']['ipv4addr'] = '172.26.1.101'
default['reserve_static_ip']['ptrdname'] = 'clogeny101.demo.com'
default['reserve_static_ip']['aliases'] = ['aliases101', 'aliases102']
default['reserve_static_ip']['record_type'] = %w(A PTR host fixedaddress)
default['reserve_static_ip']['mac'] = ''
default['reserve_static_ip']['view'] = 'default'
default['reserve_static_ip']['disable'] = false
default['reserve_static_ip']['canonical'] = 'clogeny101.demo.com'
default['reserve_static_ip']['comment'] = 'Test Record for Reserve Static IP workflow'
default['reserve_static_ip']['extattrs'] = { 'Site' => { 'value' => 'Test Value' } }
