#
# Author:: Prabhu Das (<prabhu.das@clogeny.com>)
# Author:: Ramesh Sencha (<ramesh.sencha@clogeny.com>)
# Copyright:: Infoblox
# Maintainer:: Infoblox
# License:: Apache License, Version 2.0
#
# An A (address) record maps a domain name to an IPv4 address.
actions :create, :get_record, :get_ip, :delete
default_action :create

# Name for A record in FQDN format.
attribute :name, kind_of: String, name_attribute: true, required: true
attribute :ipv4addr, kind_of: String
attribute :record_ref, kind_of: String

# optional attributes
attribute :view, kind_of: String
attribute :comment, kind_of: String
attribute :disable, kind_of: [TrueClass, FalseClass], default: false
attribute :extattrs, kind_of: Hash
