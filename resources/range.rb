actions :reserve_ip
default_action :reserve_ip

# required fields
attribute :start_addr, kind_of: String, required: true
attribute :end_addr, kind_of: String, required: true

# optional fields
attribute :name, kind_of: String
attribute :network, kind_of: String
attribute :network_view, kind_of: String
attribute :extattrs, kind_of: String
attribute :exclude, kind_of: Array
attribute :mac, kind_of: String

# To defined type of action for IP addresses
attribute :usage_type, kind_of: String, :equal_to => ["host", "dns", "fixed_address"], default: "host"
