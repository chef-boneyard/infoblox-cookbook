infoblox_ip_address "Reserve static IP" do
  name node[:ip_address][:name]
  usage_type node[:ip_address][:usage_type]
  ipv4addr node[:ip_address][:ipv4addr]
  action :reserve_static_ip
end

infoblox_ip_address "Reserve static IP" do
  name node[:ip_address][:name]
  usage_type 'dns'
  network node[:ip_address][:network]
  exclude node[:ip_address][:exclude]
  action :reserve_network_ip
end
