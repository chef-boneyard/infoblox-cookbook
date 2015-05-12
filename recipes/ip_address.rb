
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
  name node[:ip_address][:name]
  usage_type 'dns'
  network node[:ip_address][:network]
  exclude node[:ip_address][:exclude]
  action :reserve_network_ip
end
