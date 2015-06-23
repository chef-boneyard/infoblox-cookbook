actions :create, :remove
default_action :create

# Name for Host record in FQDN format.
attribute :name, kind_of: String, name_attribute: true, required: true
attribute :ipv4addr, kind_of: String, required: true
attribute :aliases, kind_of: Array
attribute :comment, kind_of: String
attribute :disable, kind_of: [TrueClass, FalseClass], default: false
attribute :extattrs, kind_of: Hash
attribute :view, kind_of: String
attribute :mac, kind_of: String
