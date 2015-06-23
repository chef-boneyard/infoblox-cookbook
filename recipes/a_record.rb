# Cookbook Name: Infoblox
# Recipe Name: a_record

include_recipe "infoblox::default"

infoblox_a_record 'Create A-record' do
  ipv4addr node['a_record']['ipv4addr']
  name node['a_record']['name']
  extattrs node['a_record']['extattrs']
  comment node['a_record']['comment']
  disable node['a_record']['disable']
  view node['a_record']['view']
  action :create
end

infoblox_a_record 'Get IP A-record' do
  name node['a_record']['name']
  ipv4addr node['a_record']['ipv4addr']
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
