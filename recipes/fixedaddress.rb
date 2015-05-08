infoblox_fixedaddress "Fixedaddress Remove" do
  ipv4addr node[:fixedaddress][:ipv4addr]
  mac node[:fixedaddress][:mac]
  name node[:fixedaddress][:name]
  action :create
end

infoblox_fixedaddress "Fixedaddress Remove" do
  ipv4addr node[:fixedaddress][:ipv4addr]
  action :get_info
end

infoblox_fixedaddress "Fixedaddress Remove" do
  ipv4addr node[:fixedaddress][:ipv4addr]
  mac node[:fixedaddress][:mac]
  action :remove
end

infoblox_fixedaddress "Fixedaddress Remove" do
  network node[:fixedaddress][:network]
  mac node[:fixedaddress][:mac]
  name node[:fixedaddress][:name]
  action :create_in_network
end