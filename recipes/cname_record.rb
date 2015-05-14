# Cookbook Name: Infoblox
# Recipe Name: cname_record

infoblox_cname_record 'Create cname-record' do
  name node['cname_record']['name']
  canonical node['cname_record']['canonical']
  action :create
end

infoblox_cname_record 'Get info of cname-record' do
  name node['cname_record']['name']
  canonical node['cname_record']['canonical']
  action :get_cname_record_info
end

infoblox_cname_record 'Delete cname-record' do
  name node['cname_record']['name']
  canonical node['cname_record']['canonical']
  action :delete
end
