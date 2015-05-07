infoblox_a_record "Create cname-record" do
  name node[:cname_record][:name]
  canonical node[:cname_record][:canonical]
  action :create
end

infoblox_a_record "Delete cname-record" do
  name node[:cname_record][:name]
  canonical node[:cname_record][:canonical]
  action :delete
end
