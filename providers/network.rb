include Infoblox::Api

action :create do
  # set request params.
  request_params = create_network_params(new_resource)
  create_network(request_params)
end

# TODO
action :delete do
  # set request params.
  request_params = create_network_params(new_resource)
  delete_network(request_params)
end

# TODO
action :get_network_info do
  request_params = create_network_params(new_resource)
  get_network_info(request_params)
end

action :get_next_ip do
  request_params = create_network_params(new_resource)
  get_next_ip_address(request_params)
end

private 

def create_network_params(new_resource)
  request_params = {}
  request_params[:network] = new_resource.network
  request_params[:network_view] = new_resource.network_view unless new_resource.network_view.nil?
  request_params[:network_container] = new_resource.network_container unless new_resource.network_container.nil? 
  request_params[:authority] = new_resource.authority unless new_resource.authority.nil?
  return request_params
end

# create a network using IP and CIDR
def create_network(params)
  network = create_network_object(params)
  begin
    network.post
    Chef::Log.info "Successfully created network."
  rescue Exception => e
    raise e.message
  end
end

# delete a network.
def delete_network(params)
  network = create_network_object(params)     
  network.network = get_network_reference(network)
  begin
    network.delete
    Chef::Log.info "Successfully deleted network."
  rescue Exception => e
    raise e.message
  end
end

def get_network_info(params)
  network = create_network_object(params) 
  network.network = params[:network]
  begin
    Chef::Log.info "Netork Information: "
    Chef::Log.info JSON.parse(network.get.body)
    Chef::Log.info "Successfully retrived network information."
  rescue Exception => e
    raise e.message
  end
end

def get_next_ip_address(params)
  network = create_network_object(params) 
  network.network = params[:network]
  begin
  	Chef::Log.info "Next available IP is : #{network.next_available_ip.first}"
  rescue Exception => e
    raise e.message
  end
end

def create_network_object(params)
  network = Infoblox::Network.new(connection: connection)
  network.network = params[:network]
  network.network_view = params[:network_view] if params[:network_view]
  network.network_container = params[:network_container] if params[:network_view]
  return network
end
