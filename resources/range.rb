actions :reserve_ip
default_action :reserve_ip

# required fields
attribute :start_addr, kind_of: String, required: true
attribute :end_addr, kind_of: String, required: true

# host attributes 
attribute :aliases, kind_of: Array
attribute :device_description, kind_of: String
attribute :configure_for_dns, kind_of: [TrueClass, FalseClass]

# dns attributes
attribute :canonical, kind_of: String
attribute :ptrdname, kind_of: String
attribute :dns_name, kind_of: String # The name for an A record in punycode format.
attribute :view, kind_of: String
attribute :zone, kind_of: String
attribute :ttl, kind_of: Integer
attribute :use_ttl, kind_of: [TrueClass, FalseClass], default: false

# fixed address attributes
attribute :mac, kind_of: String
attribute :network, kind_of: String
attribute :network_view, kind_of: String
attribute :exclude, kind_of: Array

# common optional attributes
attribute :name, kind_of: String
attribute :comment, kind_of: String
attribute :disable, kind_of: [TrueClass, FalseClass], default: false
attribute :extattrs, kind_of: Hash

# To defined type of action for IP addresses
attribute :usage_type, kind_of: String, equal_to: %w(host dns fixed_address), default: 'host'
attribute :record_type, kind_of: String, equal_to: %w(A AAAA PTR CNAME), default: 'A'
