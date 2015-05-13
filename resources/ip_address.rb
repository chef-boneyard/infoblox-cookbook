actions :reserve_static_ip, :reserve_network_ip
default_action :reserve_static_ip

# reserve IP address
attribute :name, kind_of: String, name_attribute: true, required: true
attribute :ipv4addr, kind_of: String
attribute :view, kind_of: String
attribute :mac, kind_of: String

# next available IP form network
attribute :network, kind_of: String
attribute :network_view, kind_of: String
attribute :network_container, kind_of: String
attribute :exclude, kind_of: Array

# To defined type of action for IP addresses
attribute :usage_type, kind_of: String, equal_to: %w(host dns fixed_address), default: 'host'

# extensible attributes
attribute :extattrs, kind_of: Hash
