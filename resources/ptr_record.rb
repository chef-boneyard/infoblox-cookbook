actions :create, :get_record, :get_ip, :delete
default_action :create

attribute :name, kind_of: String, name_attribute: true, required: true
attribute :ipv4addr, kind_of: String, required: true
attribute :ptrdname, kind_of: String, required: true
attribute :extattrs, kind_of: Hash
attribute :view, kind_of: String
