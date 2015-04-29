actions :reserve_static_ip, :reserve_ip_in_network, :reserve_ip_in_range
default_action :reserve_static_ip

attribute :name, kind_of: String, required: true, name_attribute: true
attribute :ipv4addr, kind_of: String, required: true
attribute :usage_type, kind_of: String, :equal_to => ["host", "dns", "fixed_address"], required: true

#optional attributes
attribute :view, kind_of: String
