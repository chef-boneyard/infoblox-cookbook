# A CNAME record maps an alias to a canonical name.
actions :create, :get_cname_record_info, :delete
default_action :create

attribute :name, kind_of: String, required: true, name_attribute: true
attribute :canonical, kind_of: String, required: true
attribute :view, kind_of: String

#optional attributes
attribute :comment, kind_of: String
attribute :disable, kind_of: [ TrueClass, FalseClass ], :default => false
attribute :dns_canonical, kind_of: String
attribute :dns_name, kind_of: String #The name for an CNAME record in punycode format.
