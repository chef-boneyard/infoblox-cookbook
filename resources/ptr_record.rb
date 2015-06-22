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
attribute :dns_name, kind_of: String # The name for an A record in punycode format.
attribute :dns_ptrdname, kind_of: String # The domain name of the DNS PTR record in punycode format.
attribute :view, kind_of: String

# Time To Live value for record. A 32-bit unsigned integer that represents the duration, in seconds, for which the record is valid (cached).
attribute :ttl, kind_of: Integer
attribute :use_ttl, kind_of: [TrueClass, FalseClass], default: false

# extensible attributes
attribute :extattrs, kind_of: Hash
