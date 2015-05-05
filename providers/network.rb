include Infoblox::Api

action :create do
# set request params.
  request_params = {}
  request_params[:network] = new_resource.network
  request_params[:network_view] = new_resource.network_view unless new_resource.network_view.nil?
  request_params[:network_container] = new_resource.network_container unless new_resource.network_container.nil? 
  request_params[:authority] = new_resource.authority unless new_resource.authority.nil?
  resp = create_network(request_params)
end