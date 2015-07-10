#
# Author:: Prabhu Das (<prabhu.das@clogeny.com>)
# Author:: Ramesh Sencha (<ramesh.sencha@clogeny.com>)
# Copyright:: Infoblox
# Maintainer:: Infoblox
# License:: Apache License, Version 2.0
#
include Infoblox::Api
use_inline_resources

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
  request_params[:comment] = new_resource.comment unless new_resource.comment.nil?
  request_params[:extattrs] = new_resource.extattrs unless new_resource.extattrs.nil?
  request_params
end

# create a network using IP and CIDR
def create_network(params)
  network_obj = Infoblox::Network.new(connection: connection, network: params[:network])
  network_obj.network_view = params[:network_view] if params[:network_view]
  network_obj.extattrs = params[:extattrs] if params[:extattrs]
  network_obj.comment = params[:comment] if params[:comment]
  begin
    resp = network_obj.post
    Chef::Log.info 'Successfully created network.'
  rescue  StandardError => e
    Chef::Log.error e.message
    return false
  end
end

# delete a network
def delete_network(params)
  network_ref = Infoblox::Network.find(connection, network: params[:network])
  unless network_ref.empty?
    begin
      resp = network_ref.first.delete
      Chef::Log.info 'Netork successfully deleted'
      return resp
    rescue StandardError => e
      Chef::Log.error e.message
      return false
    end
  else
    Chef::Log.info 'Netork Not Found'
    return false
  end
end

# To get network information
def get_network_info(params)
  network_obj = JSON.parse(Infoblox::Network.new(connection: connection, network: params[:network]).get.body)
  network_info = network_obj.select { |n| n['network'].eql?(params[:network]) || n['_ref'].match(params[:network]) }.first

  unless network_info.nil?
    Chef::Log.info 'Netork information successfully retrieved'
    return network_info
  else
    Chef::Log.info 'Netork Not Found'
    return false
  end
end
