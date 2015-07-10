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
  request_params = create_request_params
  create_ptr_record(request_params)
end

action :get_record do
  request_params = {}
  request_params[:name] = request_params[:name] = new_resource.name
  request_params[:ptrdname] = request_params[:ptrdname] = new_resource.ptrdname
  request_params[:ipv4addr] = new_resource.ipv4addr unless new_resource.ipv4addr.nil?
  request_params[:ipv6addr] = new_resource.ipv6addr unless new_resource.ipv6addr.nil?
  find_ptr_record(request_params)
end

action :delete do
  request_params = create_request_params
  remove_ptr_record(request_params)
end

private

def create_request_params
  request_params = {}
  request_params[:name] = new_resource.name
  request_params[:ptrdname] = new_resource.ptrdname
  request_params[:ipv4addr] = new_resource.ipv4addr unless new_resource.ipv4addr.nil?
  request_params[:ipv6addr] = new_resource.ipv6addr unless new_resource.ipv6addr.nil?
  request_params[:comment] = new_resource.comment unless new_resource.comment.nil?
  request_params[:view] = new_resource.view unless new_resource.view.nil?
  request_params[:extattrs] = new_resource.extattrs unless new_resource.extattrs.nil?
  request_params[:disable] = new_resource.disable
  request_params
end

def create_ptr_record(params)
  record = Infoblox::Ptr.new(connection: connection, name: params[:name], ptrdname: params[:ptrdname])
  record.ipv4addr = params[:ipv4addr] if params[:ipv4addr]
  record.extattrs = params[:extattrs] if params[:extattrs]
  record.comment = params[:comment] if params[:comment]
  record.view = params[:view] if params[:view]
  record.disable = params[:disable]
  begin
    resp = record.post
    Chef::Log.info 'PtrRecord successfully created'
    resp
  rescue StandardError => e
    Chef::Log.error e.message
    false
  end  
end

def find_ptr_record(params)
  record = Infoblox::Ptr.find(connection, params)
  if record.empty?
  	Chef::Log.info "Successfully retrived ptr record"
  	record
  else
  	Chef::Log.info "Ptr Record not found"
  end
end
