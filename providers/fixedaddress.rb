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
  request_param = {}
  request_param[:name] = new_resource.name
  request_param[:ipv4addr] = new_resource.ipv4addr
  request_param[:mac] = new_resource.mac unless new_resource.mac.nil? || new_resource.mac.empty?
  request_param[:extattrs] = new_resource.extattrs unless new_resource.extattrs.nil?
  request_param[:comment] = new_resource.comment unless new_resource.comment.nil?
  request_param[:network] = new_resource.network unless new_resource.network.nil?
  request_param[:network_view] = new_resource.network_view unless new_resource.network_view.nil?
  create_fixedaddress_record(request_param)
end

action :get_info do
  request_param = {}
  request_param[:ipv4addr] = new_resource.ipv4addr
  record = Infoblox::Fixedaddress.find(connection, request_param).first

  begin
    unless record.nil?
      Chef::Log.info 'Fixedaddress information successfully retrived'
      record
    else
      Chef::Log.info 'Fixedaddress record not found'
      false
    end
  rescue StandardError => e
    Chef::Log.error e.message
    false
  end
end

# delete : fixedaddress search will be perform on the basis of ipv4addr, it will ignore mac address and name (hostname)
action :remove do
  request_param = {}
  request_param[:ipv4addr] = new_resource.ipv4addr
  remove_fixedaddress_record(request_param)
end
