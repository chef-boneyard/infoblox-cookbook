
infoblox_ip_address "Reserve static IP" do
  name "clogeny04.test.local"
  ipv4addr "10.10.70.4"
  action :reserve_static_ip
end

infoblox_ip_address "Reserve static IP" do
  name "clogeny05.test.local"
  usage_type 'dns'
  ipv4addr "10.10.70.5"
  action :reserve_static_ip
end
