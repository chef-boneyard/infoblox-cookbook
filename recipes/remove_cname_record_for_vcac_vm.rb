# Cookbook Name: Infoblox
# Recipe Name: remove_cname_record_for_vcac_vm

infoblox_cname_record 'Delete cname-record' do
  name node['cname_record']['name']
  canonical node['cname_record']['canonical']
  action :delete
end
