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
  request_params = {}
  request_params[:name] = new_resource.name
  request_params[:aliases] = new_resource.aliases unless new_resource.aliases.nil?
  request_params[:comment] = new_resource.comment unless new_resource.comment.nil?
  request_params[:disable] = new_resource.disable
  request_params[:extattrs] = new_resource.extattrs unless new_resource.extattrs.nil?
  request_params[:view] = new_resource.view unless new_resource.view.nil?
  request_params[:ipv4addrs] = [{ ipv4addr: new_resource.ipv4addr, mac: new_resource.mac }]

  create_host_record(request_params)
end

action :create_or_update do
  request_params = {}
  request_params[:name] = new_resource.name
  request_params[:aliases] = new_resource.aliases unless new_resource.aliases.nil?
  request_params[:comment] = new_resource.comment unless new_resource.comment.nil?
  request_params[:disable] = new_resource.disable
  request_params[:extattrs] = new_resource.extattrs unless new_resource.extattrs.nil?
  request_params[:view] = new_resource.view unless new_resource.view.nil?
  request_params[:ipv4addrs] = [{ ipv4addr: new_resource.ipv4addr, mac: new_resource.mac }]
  request_params[:replace_ipv4addrs] = new_resource.replace_ipv4addrs

  create_or_update_host_record(request_params)
end

action :update do
  request_params = {}
  request_params[:name] = new_resource.name
  request_params[:aliases] = new_resource.aliases unless new_resource.aliases.nil?
  request_params[:comment] = new_resource.comment unless new_resource.comment.nil?
  request_params[:disable] = new_resource.disable
  request_params[:extattrs] = new_resource.extattrs unless new_resource.extattrs.nil?
  request_params[:view] = new_resource.view unless new_resource.view.nil?
  request_params[:ipv4addrs] = [{ ipv4addr: new_resource.ipv4addr, mac: new_resource.mac }]
  request_params[:replace_ipv4addrs] = new_resource.replace_ipv4addrs

  update_host_record(request_params)
end

action :remove do
  request_params = {}
  request_params[:name] = new_resource.name
  request_params[:ipv4addr] = new_resource.ipv4addr unless new_resource.ipv4addr.nil?

  remove_host_record(request_params)
end
