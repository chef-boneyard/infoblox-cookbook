# Cookbook Name: Infoblox
# Recipe Name: aaaa_record

infoblox_aaaa_record 'Create AAAA-record' do
  ipv6addr node['aaaa_record']['ipv6addr']
  name node['aaaa_record']['name']
  comment node['aaaa_record']['comment']
  action :create
end

infoblox_aaaa_record 'Delete AAAA-record' do
  ipv6addr node['aaaa_record']['ipv6addr']
  name node['aaaa_record']['ipv6addr']
  action :delete
end
