# Cookbook Name: Infoblox
# Recipe Name: aaaa_record

infoblox_aaaa_record 'Create AAAA-record' do
  ipv4addr node['aaaa_record']['ipv6addr']
  name node['aaaa_record']['name']
  action :create
end

infoblox_aaaa_record 'Delete AAAA-record' do
  name node['aaaa_record']['ipv6addr']
  action :delete
end
