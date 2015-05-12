
infoblox_network "Create Network" do
  network node[:network][:subnet]
  extattrs node[:network][:extattrs]
  action :create
end

infoblox_network "Get Network information" do
  network node[:network][:subnet] || node[:network][:network_ref] 
  action :get_network_info
end

infoblox_network "Get next available Network IP" do
  network node[:network][:subnet]
  action :get_next_ip
end

infoblox_network "Delete Network" do
  network node[:network][:subnet]
  action :delete
end
