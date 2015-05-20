actions :provision, :deprovision, :power_on, :power_off
default_action :provision

# RbVmomi required fields
attribute :host, kind_of: String, required: true
attribute :user, kind_of: String, required: true
attribute :password, kind_of: String, required: true
attribute :name, kind_of: String, required: true
attribute :guest_id, kind_of: String
attribute :datacenter, kind_of: String, required: true
attribute :network, kind_of: String
attribute :datastore, kind_of: String

attribute :num_cpus, kind_of: Integer, default: 1
attribute :memory_mb, kind_of: Integer, default: 128
attribute :disk_mode, kind_of: String, default: 'persistent'
attribute :thin_provisioned, kind_of: [TrueClass, FalseClass], default: true
