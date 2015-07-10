#
# Author:: Prabhu Das (<prabhu.das@clogeny.com>)
# Author:: Ramesh Sencha (<ramesh.sencha@clogeny.com>)
# Copyright:: Infoblox
# Maintainer:: Infoblox
# License:: Apache License, Version 2.0
#
include Infoblox::Api
use_inline_resources

RECORD_TYPES = [ 'A', 'AAAA', 'PTR', 'CNAME', 'host', 'fixedaddress' ]
DNS_RECORDS = [ 'A', 'AAAA', 'PTR', 'CNAME' ]

action :reserve do
  request_params = set_request_params

  if (request_params[:record_type] - RECORD_TYPES).empty?
    request_params[:record_type].each { |record|
      if record.eql?('host')
        request_params[:aliases] = new_resource.aliases unless new_resource.aliases.nil?
        request_params[:device_description] = new_resource.device_description unless new_resource.device_description.nil?
        request_params[:configure_for_dns] = new_resource.configure_for_dns unless new_resource.configure_for_dns.nil?
        request_params[:ipv4addrs] = [{ ipv4addr: request_params[:ipv4addr], mac: new_resource.mac }]
      else
        request_params[:mac] = new_resource.mac unless new_resource.mac.nil?
      end
      if DNS_RECORDS.include?(record)
        create_dns_record(request_params, record)
      else
        send("create_#{record.downcase}_record", request_params)
      end
    }
  else
    raise "Expected values are #{RECORD_TYPES}, please specify the correct value."
  end
end

action :remove do
  request_params = set_request_params
  if (request_params[:record_type] - RECORD_TYPES).empty?
    request_params[:record_type].each { |record|
      send("remove_#{record.downcase}_record", request_params)
    }
  else
    raise "Expected values are #{RECORD_TYPES}, please specify the correct value."
  end
end

private 

def set_request_params
  params = {}
  params[:record_type] = new_resource.record_type
  params[:name] = new_resource.name
  params[:ipv4addr] = new_resource.ipv4addr || node['vcenter']['vm']['ipaddress']
  params[:comment] = new_resource.comment  unless new_resource.comment.nil?
  params[:extattrs] = new_resource.extattrs unless new_resource.extattrs.nil?
  params[:disable] = new_resource.disable
  params[:view] = new_resource.view unless new_resource.view.nil?
  # PTR
  params[:ptrdname] = new_resource.ptrdname  unless new_resource.ptrdname.nil?
  # CNAME
  params[:canonical] = new_resource.canonical unless new_resource.canonical.nil?
  # fixed address
  params[:network] = new_resource.network unless new_resource.network.nil?
  params[:network_view] = new_resource.network_view unless new_resource.network_view.nil?
  params
end
