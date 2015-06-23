# Cookbook Name: Infoblox
# Recipe Name: cname_record

include_recipe "infoblox::default"

infoblox_cname_record 'Create cname-record' do
  name node['cname_record']['name']
  canonical node['cname_record']['canonical']
  comment node['cname_record']['comment']
  extattrs node['cname_record']['extattrs']
  view node['cname_record']['view']
  disable node['cname_record']['disable']
  action :create
end

infoblox_cname_record 'Get info of cname-record' do
  name node['cname_record']['name']
  canonical node['cname_record']['canonical']
  action :get_record
end

infoblox_cname_record 'Delete cname-record' do
  name node['cname_record']['name']
  canonical node['cname_record']['canonical']
  action :delete
end
