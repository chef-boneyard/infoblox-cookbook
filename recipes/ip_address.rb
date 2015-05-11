infoblox_ip_address "Reserve static IP" do
  name node[:ip_address][:name]
  usage_type node[:ip_address][:usage_type]
  ipv4addr node[:ip_address][:ipv4addr]
  action :reserve_static_ip
end

infoblox_ip_address "Reserve IP in Range" do
  name node[:ip_address][:ipv4addr]
  usage_type node[:ip_address][:usage_type]
  start_addr node[:ip_address][:start_addr]
  end_addr node[:ip_address][:end_addr]
  mac node[:ip_address][:mac]
  action :reserve_ip_in_range
end
