include Infoblox::Api
require 'faraday'
require 'net/http'

action :create do
  request_params = create_network_params(new_resource)
  create_network(request_params)
end

action :delete do
  request_params = create_network_params(new_resource)
  delete_network(request_params)
end

action :get_network_info do
  request_params = create_network_params(new_resource)
  get_network_info(request_params)
end

action :get_next_ip do
  request_params = create_network_params(new_resource)
  get_next_ip_address(request_params)
end

private

# create network params from recipe attributes
def create_network_params(new_resource)
  request_params = {}
  request_params[:network] = new_resource.network unless new_resource.network.nil?
  request_params[:network_view] = new_resource.network_view unless new_resource.network_view.nil?
  request_params[:network_container] = new_resource.network_container unless new_resource.network_container.nil? 
  request_params[:authority] = new_resource.authority unless new_resource.authority.nil?
  return request_params
end

# create a network using IP and CIDR
def create_network(params)
  network_obj = Infoblox::Network.new(connection: connection)
  network_obj.network = params[:network]
  network_obj.network_view = params[:network_view] if params[:network_view]
  network_obj.network_container = params[:network_container] if params[:network_view]
  begin
    network_obj.post
    Chef::Log.info "Successfully created network."
  rescue  StandardError => e
    unless e.message.match(/Client.Ibap.Data.Conflict/).nil?
      Chef::Log.info "Network already exists, Please select another network."
    else
      raise e.message
    end
  end
end

# delete a network
def delete_network(params)
  network_ref = Infoblox::Network.find(connection, network: params[:network])
  unless network_ref.empty?
    begin
      network_ref.first.delete
      Chef::Log.info "Netork successfully deleted"
    rescue Exception => e
      Chef::Log.error e.message
    end
  else
    Chef::Log.info "Netork Not Found"
  end
end

# To get network information
def get_network_info(params)
  network_obj = JSON.parse(Infoblox::Network.new(connection: connection, network: params[:network]).get.body)
  network_info = network_obj.select{|n| n["network"].eql?(params[:network]) || n["_ref"].match(params[:network]) }.first

  unless network_info.nil?
    network_info
    Chef::Log.info "Netork information successfully retrieved"
  else
    Chef::Log.info "Netork Not Found"
  end
end
