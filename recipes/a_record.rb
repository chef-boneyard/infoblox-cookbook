infoblox_a_record "Create A-record" do
  ipv4addr node[:a_record][:ipv4addr]
  name node[:a_record][:name]
  action :create
end

infoblox_a_record "Delete A-record" do
  name node[:a_record][:ipv4addr]
  action :delete
end
