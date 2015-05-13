
actions :create, :get_network_info, :get_next_ip, :delete
default_action :create

attribute :network, kind_of: String, required: true

# optional attributes
attribute :network_view, kind_of: String
attribute :network_container, kind_of: String
attribute :authority, kind_of: [TrueClass, FalseClass], default: false

# extensible attributes
attribute :extattrs, kind_of: Hash
