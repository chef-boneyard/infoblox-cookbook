#
# Author:: Prabhu Das (<prabhu.das@clogeny.com>)
# Author:: Ramesh Sencha (<ramesh.sencha@clogeny.com>)
# Copyright:: Infoblox
# Maintainer:: Infoblox
# License:: Apache License, Version 2.0
#
actions :create, :create_or_update, :update, :remove
default_action :create

# Name for Host record in FQDN format.
attribute :name, kind_of: String, name_attribute: true, required: true
attribute :ipv4addr, kind_of: String, required: true
attribute :aliases, kind_of: Array
attribute :comment, kind_of: String
attribute :disable, kind_of: [TrueClass, FalseClass], default: false
attribute :extattrs, kind_of: Hash
attribute :view, kind_of: String
attribute :mac, kind_of: String
# Replace any existing Infoblox::HostIpv4addr with what the resource provides.
# Default behavior is to add to the existing list of Infoblox::HostIpv4addr.
attribute :replace_ipv4addrs, kind_of: [TrueClass, FalseClass], default: false
