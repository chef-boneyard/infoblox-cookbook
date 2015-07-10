#
# Author:: Prabhu Das (<prabhu.das@clogeny.com>)
# Author:: Ramesh Sencha (<ramesh.sencha@clogeny.com>)
# Copyright:: Infoblox
# Maintainer:: Infoblox
# License:: Apache License, Version 2.0
#
# A CNAME record maps an alias to a canonical name.
actions :create, :get_record, :delete
default_action :create

attribute :name, kind_of: String, required: true, name_attribute: true
attribute :canonical, kind_of: String, required: true
attribute :view, kind_of: String

# optional attributes
attribute :comment, kind_of: String
attribute :disable, kind_of: [TrueClass, FalseClass], default: false
attribute :dns_canonical, kind_of: String
attribute :dns_name, kind_of: String # The name for an CNAME record in punycode format.

# Time To Live value for record. A 32-bit unsigned integer that represents the duration, in seconds, for which the record is valid (cached).
attribute :ttl, kind_of: Integer
attribute :use_ttl, kind_of: [TrueClass, FalseClass], default: false

# extensible attributes
attribute :extattrs, kind_of: Hash
