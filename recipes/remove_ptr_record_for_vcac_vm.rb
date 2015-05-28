# Cookbook Name: Infoblox
# Recipe Name: remove_ptr_record_for_vcac_vm

infoblox_ptr_record "Delete a ptr record" do
  ipv4addr node['ptr_record']['ipv4addr']
  ptrdname node['ptr_record']['ptrdname']
  action :delete
end
