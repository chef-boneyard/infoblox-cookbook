actions :provision, :deprovision, :power_on, :power_off
default_action :provision

# RbVmomi required fields
attribute :host, kind_of: String, required: true
attribute :user, kind_of: String, required: true
attribute :password, kind_of: String, required: true
attribute :name, kind_of: String
attribute :hostname, kind_of: String
attribute :template_path, kind_of: String
attribute :datacenter, kind_of: String, required: true
attribute :datastore, kind_of: String
attribute :ip, kind_of: String
attribute :gateway, kind_of: Array
attribute :subnet_mask, kind_of: String
attribute :domain, kind_of: String
attribute :pubkey_hash, kind_of: String
attribute :force, kind_of: [TrueClass, FalseClass], default: false
attribute :network_adapter, kind_of: String
attribute :usage_type, kind_of: String
attribute :dns_server_list, kind_of: Array
