#
# Author:: Prabhu Das (<prabhu.das@clogeny.com>)
# Author:: Ramesh Sencha (<ramesh.sencha@clogeny.com>)
# Copyright:: Infoblox
# Maintainer:: Infoblox
# License:: Apache License, Version 2.0
#
# NIOS host details
default['infoblox']['nios_appliance'] = '' # ip address of the vNIOS appliance
default['infoblox']['username'] = ''       # username of the vNIOS appliance
default['infoblox']['password'] = ''       # password of the vNIOS appliance

# vSphere vcenter server host details
default['vcenter']['vcenter_host'] = '' # vCenter server host IP
default['vcenter']['username'] = '' # vCenter server host username
default['vcenter']['password'] = '' # vCenter server host password
default['vcenter']['insecure'] = true

default['infoblox']['data_bag_name'] = 'infoblox'
default['infoblox']['data_bag_item'] = 'credentials'
