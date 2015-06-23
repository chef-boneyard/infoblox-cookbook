# Cookbook Name: Infoblox
# Recipe Name: aaaa_record

include_recipe "infoblox::default"

infoblox_aaaa_record 'Create AAAA-record' do
  ipv6addr node['aaaa_record']['ipv6addr']
  name node['aaaa_record']['name']
  comment node['aaaa_record']['comment']
  disable node['aaaa_record']['disable']
  extattrs node['aaaa_record']['extattrs']
  view node['aaaa_record']['view']
  action :create
end

infoblox_aaaa_record 'Delete AAAA-record' do
  ipv6addr node['aaaa_record']['ipv6addr']
  name node['aaaa_record']['name']
  action :delete
end
