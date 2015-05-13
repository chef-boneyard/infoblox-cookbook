infoblox_ip_address "Reserve static IP for host record" do
  name node["ip_address"]["name"]
  usage_type node["ip_address"]["usage_type"]
  ipv4addr node["ip_address"]["ipv4addr"]
  extattrs node["ip_address"]["extattrs"]
  action :reserve_static_ip
end

infoblox_ip_address "Reserve static IP for DNS record" do
  name node["ip_address"]["name"]
  usage_type node["ip_address"]["usage_type"]
  network node["ip_address"]["network"]
  exclude node["ip_address"]["exclude"]
  extattrs node["ip_address"]["extattrs"]
  ipv4addr node["ip_address"]["ipv4addr"]
  action :reserve_network_ip
end

infoblox_ip_address "Reserve static IP for fixed_address" do
  name node["ip_address"]["name"]
  usage_type node["ip_address"]["usage_type"]
  network node["ip_address"]["network"]
  exclude node["ip_address"]["exclude"]
  extattrs node["ip_address"]["extattrs"]
  ipv4addr node["ip_address"]["ipv4addr"]
  action :reserve_network_ip
end
