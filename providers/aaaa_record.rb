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
  request_params = get_request_params
  create_aaaa_record(request_params)
end

action :get_record do
  request_params = get_request_params

  begin
    record = Infoblox::AAAArecord.find(connection, name: request_params[:name])
    unless record.empty?
      Chef::Log.info 'AAAA record information retrieved successfully'
      record
    else
      Chef::Log.info 'AAAA record information not found'
      false
    end
  rescue StandardError => e
    Chef::Log.error e.message
    false
  end
end

action :delete do
  Chef::Log.info 'Action : delete record on the basis of IP address.'
  request_params = get_request_params
  remove_aaaa_record(request_params)
end

private

# create AAAA-record params of recipe attributes
def get_request_params
  request_params = {}
  request_params[:name] = new_resource.name
  request_params[:ipv6addr] = new_resource.ipv6addr
  request_params[:comment] = new_resource.comment unless new_resource.comment.nil?
  request_params[:view] = new_resource.view unless new_resource.view.nil?
  request_params[:disable] = new_resource.disable
  request_params[:extattrs] = new_resource.extattrs unless new_resource.extattrs.nil?
  request_params
end

def create_aaaa_record(params)
  record = Infoblox::AAAArecord.new(connection: connection, name: params[:name], ipv6addr: params[:ipv6addr])
  record.view = params[:view] if params[:view]
  record.comment = params[:comment] if params[:comment]
  record.disable = params[:disable]
  record.extattrs = params[:extattrs] if params[:extattrs]
  begin
    resp = record.post
    Chef::Log.info 'AAAA-record successfully created.'
    return resp
  rescue StandardError => e
    Chef::Log.error e.message
    return false
  end
end
