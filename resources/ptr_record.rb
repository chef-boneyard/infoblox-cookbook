#
# Author:: Prabhu Das (<prabhu.das@clogeny.com>)
# Author:: Ramesh Sencha (<ramesh.sencha@clogeny.com>)
# Copyright:: Infoblox
# Maintainer:: Infoblox
# License:: Apache License, Version 2.0
#
actions :create, :get_record, :delete
default_action :create

attribute :name, kind_of: String, name_attribute: true, required: true
attribute :ptrdname, kind_of: String, required: true

# either of these two attributes is required
attribute :ipv4addr, kind_of: String
attribute :ipv6addr, kind_of: String

# optional attributes
attribute :comment, kind_of: String
attribute :disable, kind_of: [TrueClass, FalseClass], default: false
attribute :view, kind_of: String
attribute :extattrs, kind_of: Hash
