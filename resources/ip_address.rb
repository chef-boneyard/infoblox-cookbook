#
# Author:: Prabhu Das (<prabhu.das@clogeny.com>)
# Author:: Ramesh Sencha (<ramesh.sencha@clogeny.com>)
# Copyright:: Infoblox
# Maintainer:: Infoblox
# License:: Apache License, Version 2.0
#
actions :reserve, :remove
default_action :reserve

# reserve IP address
attribute :name, kind_of: String, name_attribute: true, required: true
attribute :ipv4addr, kind_of: String

# host attributes 
attribute :aliases, kind_of: Array
attribute :device_description, kind_of: String
attribute :configure_for_dns, kind_of: [TrueClass, FalseClass]

# dns attributes
attribute :canonical, kind_of: String
attribute :ptrdname, kind_of: String
attribute :ipv6addr, kind_of: String # AAAA record
attribute :dns_name, kind_of: String # The name for an A record in punycode format.
attribute :view, kind_of: String
attribute :ttl, kind_of: Integer
attribute :use_ttl, kind_of: [TrueClass, FalseClass], default: false

# fixedaddress/reservation attributes
attribute :mac, kind_of: String
attribute :network, kind_of: String
attribute :network_view, kind_of: String

# common optional attributes
attribute :comment, kind_of: String
attribute :disable, kind_of: [TrueClass, FalseClass], default: false
attribute :extattrs, kind_of: Hash

# To defined type of action for IP addresses
attribute :record_type, kind_of: Array, default: ['host']
