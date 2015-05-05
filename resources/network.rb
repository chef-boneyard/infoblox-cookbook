
actions :create, :get_network_info_by_ref, :get_next_ip, :delete
default_action :create

attribute :network, kind_of: String, name_attribute: true, required: true

#optional attributes
attribute :network_view, kind_of: String
attribute :network_container, kind_of: String
attribute :authority, kind_of: [ TrueClass, FalseClass ], :default => false
