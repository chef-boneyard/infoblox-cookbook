# Cookbook Name: Infoblox
# Recipe Name: ptr_record

include_recipe "infoblox::default"

# In forward mapping zone, PTR (pointer) record maps a domain name to the other domain name.
# In Reverse mapping zone, PTR (pointer) record maps an address to domain name.
infoblox_ptr_record "Create a ptr record" do
  name node['ptr_record']['name']
  ptrdname node['ptr_record']['ptrdname']
  extattrs node['ptr_record']['extattrs']
  comment node['ptr_record']['comment']
  disable node['ptr_record']['disable']
  action :create
end

infoblox_ptr_record "Get ptr info" do
  ipv4addr node['ptr_record']['ipv4addr']
  ptrdname node['ptr_record']['ptrdname']
  action :get_record
end

infoblox_ptr_record "Delete a ptr record" do
  name node['ptr_record']['name']
  ptrdname node['ptr_record']['ptrdname']
  action :delete
end
