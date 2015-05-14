# Cookbook Name: Infoblox
# Recipe Name: a_record

infoblox_a_record 'Create A-record' do
  ipv4addr node['a_record']['ipv4addr']
  name node['a_record']['name']
  extattrs node['a_record']['extattrs']
  action :create
end

infoblox_a_record 'Get IP A-record' do
  name node['a_record']['name']
  action :get_record
end

infoblox_a_record 'Get IP A-record' do
  record_ref node['a_record']['record_ref']
  action :get_ip
end

infoblox_a_record 'Delete A-record' do
  ipv4addr node['a_record']['ipv4addr']
  name node['a_record']['name']
  action :delete
end
