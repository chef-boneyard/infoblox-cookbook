infoblox_ptr_record "Create a ptr record" do
  name node['ptr_record']['name']
  ipv4addr node['ptr_record']['ipv4addr']
  ptrdname node['ptr_record']['ptrdname']
  extattrs node['ptr_record']['extattrs']
end

infoblox_ptr_record "Create a ptr record" do
  ipv4addr node['ptr_record']['ipv4addr']
  ptrdname node['ptr_record']['ptrdname']
  action :get_record
end

infoblox_ptr_record "Create a ptr record" do
  ipv4addr node['ptr_record']['ipv4addr']
  ptrdname node['ptr_record']['ptrdname']
  action :delete
end
