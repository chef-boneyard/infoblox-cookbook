#
# Author:: Prabhu Das (<prabhu.das@clogeny.com>)
# Author:: Ramesh Sencha (<ramesh.sencha@clogeny.com>)
# Copyright:: Infoblox
# Maintainer:: Infoblox
# License:: Apache License, Version 2.0
#
actions :create, :get_network_info, :get_next_ip, :delete
default_action :create

attribute :network, kind_of: String, required: true

# optional attributes
attribute :network_view, kind_of: String
attribute :comment, kind_of: String
attribute :extattrs, kind_of: Hash
