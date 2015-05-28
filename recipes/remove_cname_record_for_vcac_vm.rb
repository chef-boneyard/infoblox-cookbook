# Cookbook Name: Infoblox
# Recipe Name: remove_arecord

infoblox_cname_record 'Delete cname-record' do
  name node['cname_record']['name']
  canonical node['cname_record']['canonical']
  action :delete
end
