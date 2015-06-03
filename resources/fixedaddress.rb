# An A (address) record maps a domain name to an IPv4 address.
actions :create, :delete, :get_info, :create_in_network
default_action :create

# Name for A record in FQDN format.
attribute :ipv4addr, kind_of: String, required: true
attribute :name, kind_of: String, required: true
attribute :mac, kind_of: String
attribute :network, kind_of: String
attribute :exclude, kind_of: Array
attribute :network_view, kind_of: String

# common attributes
attribute :comment, kind_of: String
attribute :disable, kind_of: [TrueClass, FalseClass], default: false
attribute :extattrs, kind_of: Hash
