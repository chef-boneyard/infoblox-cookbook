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
  create_a_record(request_params)
end

action :get_record do
  request_params = get_request_params
  Chef::Log.info 'Action : get_record on the basis of hostname/FQDN'

  begin
    record = Infoblox::Arecord.find(connection, name: request_params[:name])
    unless record.empty?
      Chef::Log.info 'Arecord information retrieved successfully'
      record
    else
      Chef::Log.info 'Arecord information not found'
      false
    end
  rescue StandardError => e
    Chef::Log.error e.message
    false
  end
end

action :get_ip do
  Chef::Log.info 'Action : get IP on the basis of object reference/hostname/ipv4address.'
  request_params = get_request_params
  begin
    ips = []
    unless request_params[:record_ref].nil?
      record = JSON.parse(Infoblox::Arecord.new(connection: connection).get.body)
      a_record = record.select { |ref| ref['_ref'].match(request_params[:record_ref]) }
      a_record.each { |record| ips << record['ipv4addr'] }
    else
      Infoblox::Arecord.find(connection, request_params).each { |record| ips << record.ipv4addr }
    end
    unless ips.empty?
      Chef::Log.info 'A-record IP information successfully retrieved'
      ips
    else
      Chef::Log.info 'A-record IP not found'
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
  remove_a_record(request_params)
end

private

# create A-record params from recipe attributes
def get_request_params
  request_params = {}
  request_params[:name] = new_resource.name
  request_params[:ipv4addr] = new_resource.ipv4addr
  request_params[:comment] = new_resource.comment unless new_resource.comment.nil?
  request_params[:view] = new_resource.view unless new_resource.view.nil?
  request_params[:extattrs] = new_resource.extattrs unless new_resource.extattrs.nil?
  request_params[:comment] = new_resource.comment unless new_resource.comment.nil?
  request_params[:disable] = new_resource.disable
  request_params[:record_ref] = new_resource.record_ref unless new_resource.record_ref.nil?
  request_params
end

def create_a_record(params)
  record = Infoblox::Arecord.new(connection: connection,
                                name: params[:name],
                                ipv4addr: params[:ipv4addr],
                                view: params[:view],
                                extattrs: params[:extattrs])
  begin
    resp = record.post
    Chef::Log.info 'A-record successfully created.'
    return resp
  rescue StandardError => e
    Chef::Log.error e.message
    return false
  end
end
