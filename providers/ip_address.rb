include Infoblox::Api

action :reserve_static_ip do

  # validation
  is_valid_ip?(new_resource.ipv4addr)    

  # set request params.
  request_params = {}
  request_params[:name] = new_resource.name
  request_params[:ipv4addr] = new_resource.ipv4addr
  request_params[:view] = new_resource.view unless new_resource.view.nil? 

  resp = request(new_resource.usage_type, request_params)

end

action :reserve_ip_in_network do
  Chef::Log.info "Action : reserve_static_ip"
end

action :reserve_ip_in_range do
  Chef::Log.info "Action : reserve_ip_in_range"
end
