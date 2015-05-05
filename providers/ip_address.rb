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

action :reserve_network_ip do
  Chef::Log.info "Action : reserve_static_ip"

  # set request params.
  request_params = {}
  request_params[:network] = new_resource.network
  request_params[:network_view] = new_resource.network_view unless new_resource.network_view.nil?
  request_params[:network_container] = new_resource.network_container unless new_resource.network_container.nil?

  # get next available ip address from defined network
  request_params[:ipv4addr] = get_ip_address(params)

  resp = request(new_resource.usage_type, request_params)

end

action :reserve_ip_in_range do
  Chef::Log.info "Action : reserve_ip_in_range"
end
