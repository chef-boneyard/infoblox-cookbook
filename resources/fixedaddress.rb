# An A (address) record maps a domain name to an IPv4 address.
actions :remove, :create, :get_info, :create_in_network
default_action :create

# Name for A record in FQDN format.
attribute :mac, kind_of: String, name_attribute: true
attribute :ipv4addr, kind_of: String, required: true
attribute :network, kind_of: String
attribute :name, kind_of: String
