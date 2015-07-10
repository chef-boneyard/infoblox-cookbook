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
  create_cname_record(request_params)
end

action :delete do
  request_params = get_request_params
  remove_cname_record(request_params)
end

action :get_record do
  request_params = get_request_params
  record = find_cname_record(request_params)
  unless record.empty?
    resp = record.first
    Chef::Log.info 'Successfully retrived CNAME record.'
    resp
  else
    Chef::Log.info 'CNAME record not found.'
    false
  end
end

private

def get_request_params
  request_params = {}
  request_params[:name] = new_resource.name
  request_params[:canonical] = new_resource.canonical
  request_params[:comment] = new_resource.comment unless new_resource.comment.nil?
  request_params[:disable] = new_resource.disable
  request_params[:view] = new_resource.view unless new_resource.view.nil?
  request_params[:extattrs] = new_resource.extattrs unless new_resource.extattrs.nil?
  request_params
end

# create cname-record
def create_cname_record(params)
  record = Infoblox::Cname.new(connection: connection, name: params[:name], canonical: params[:canonical])
  record.comment = params[:comment] if params[:comment]
  record.disable = params[:disable]
  record.extattrs = params[:extattrs] if params[:extattrs]
  record.view = params[:view] if params[:view]
  begin
    resp = record.post
    Chef::Log.info 'cname-record successfully created.'
    return resp
  rescue StandardError => e
    Chef::Log.error e.message
    return false
  end
end

def find_cname_record(params)
  Infoblox::Cname.find(connection, name: params[:name], canonical: params[:canonical])
end
