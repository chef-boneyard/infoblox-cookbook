
infoblox_ip_address "Reserve static IP" do
  name node[:ip_address][:name]
  ipv4addr node[:ip_address][:ipv4addr]
  action :reserve_static_ip
end

infoblox_ip_address "Reserve static IP" do
  name node[:ip_address][:name]
  usage_type 'dns'
  ipv4addr node[:ip_address][:ipv4addr]
  action :reserve_static_ip
end

infoblox_ip_address "Reserve static IP" do
  name node[:ip_address][:ipv4addr]
  usage_type 'fixed_address'
  start_addr node[:ip_address][:start_addr]
  end_addr node[:ip_address][:end_addr]
  mac node[:ip_address][:mac]
  action :reserve_ip_in_range
end
