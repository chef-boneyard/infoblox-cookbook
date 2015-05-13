include Infoblox::Api
use_inline_resources

action :create do
  # validation
  valid_ip?(new_resource.ipv4addr)

  # set request params.
  request_params = {}
  request_params[:name] = new_resource.name
  request_params[:ipv4addr] = new_resource.ipv4addr
  request_params[:view] = new_resource.view unless new_resource.view.nil?
  request_params[:extattrs] = new_resource.extattrs unless new_resource.extattrs.nil?
  create_a_record(request_params)
end

action :get_record do
  request_params = {}
  request_params[:name] = new_resource.name
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
    Chef::Log.error get_error_message(e.message)
    false
  end
end

action :get_ip do
  Chef::Log.info 'Action : get IP on the basis of object reference/hostname/ipv4address.'
  request_params = {}
  request_params[:name] = new_resource.name unless new_resource.name.nil?
  request_params[:ipv4addr] = new_resource.ipv4addr unless new_resource.ipv4addr.nil?
  request_params[:record_ref] = new_resource.record_ref unless new_resource.record_ref.nil?

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
    Chef::Log.error get_error_message(e.message)
    false
  end
end

action :delete do
  Chef::Log.info 'Action : delete record on the basis of IP address.'
  request_params = create_a_record_params(new_resource)
  delete_a_record(request_params)
end

private

# delete A-record
def delete_a_record(params)
  a_record_obj = Infoblox::Arecord.find(connection, params)
  unless a_record_obj.empty?
    begin
      a_record_obj.each { |record| record.delete }
      Chef::Log.info 'Arecord(s) successfully deleted'
      return true
    rescue StandardError => e
      Chef::Log.error get_error_message(e.message)
      return false
    end
  else
    Chef::Log.info 'Arecord Not Found. Please verify IP address and hostname.'
    return false
  end
end

# create A-record params from recipe attributes
def create_a_record_params(new_resource)
  request_params = {}
  request_params[:name] = new_resource.name
  request_params[:ipv4addr] = new_resource.ipv4addr
  request_params
end

def create_a_record(params)
  record = Infoblox::Arecord.new(connection: connection, name: params[:name], ipv4addr: params[:ipv4addr])
  record.view = params[:view] if params[:view]
  record.extattrs = params[:extattrs] if params[:extattrs]
  begin
    resp = record.post
    Chef::Log.info 'A-record successfully created.'
    return resp
  rescue StandardError => e
    Chef::Log.error get_error_message(e.message)
    return false
  end
end
