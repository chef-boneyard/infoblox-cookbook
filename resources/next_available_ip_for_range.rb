actions :find
default_action :find

attribute :start_addr, kind_of: String, required: true
attribute :end_addr, kind_of: String, required: true
attribute :exclude, kind_of: Array
