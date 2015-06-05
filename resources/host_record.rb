actions :delete
default_action :delete

# Name for Host record in FQDN format.
attribute :name, kind_of: String, name_attribute: true, required: true
attribute :ipv4addr, kind_of: String
