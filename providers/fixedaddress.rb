include Infoblox::Api

use_inline_resources

action :create do
  request_param = {}
  request_param[:name] = new_resource.name
  request_param[:ipv4addr] = new_resource.ipv4addr
  request_param[:mac] = new_resource.mac unless new_resource.mac.nil?
  request_param[:extattrs] = new_resource.extattrs unless new_resource.extattrs.nil?
  record = Infoblox::Fixedaddress.new(connection: connection, ipv4addr: request_param[:ipv4addr])
  record.name = request_param[:name] unless request_param[:name].nil?
  record.mac = request_param[:mac] unless request_param[:mac].nil?
  record.extattrs = request_param[:extattrs] if request_param[:extattrs]
  begin
    resp = record.post
    Chef::Log.info "Fixedaddress successfully created"
    resp
  rescue Exception => e
    Chef::Log.error e.message.split("text\":")[1].chomp('}')
  end  
end

action :get_info do
  request_param = {}
  request_param[:ipv4addr] = new_resource.ipv4addr
  record = Infoblox::Fixedaddress.find(connection, request_param).first

  begin
    unless record.nil?
      Chef::Log.info "Fixedaddress information successfully retrived"
      record
    else
      Chef::Log.info "Fixedaddress record not found"
      false
    end
  rescue Exception => e
    Chef::Log.error e.message.split("text\":")[1].chomp('}')
    false
  end  
end

# Remove : fixedaddress search will be perform on the basis of ipv4addr, it will ignore mac address and name (hostname)
action :remove do
  request_param = {}
  request_param[:ipv4addr] = new_resource.ipv4addr
  record = Infoblox::Fixedaddress.find(connection, request_param).first
  begin
    unless record.nil?
      resp = record.delete
      Chef::Log.info "Fixedaddress successfully deleted"
      resp
    else
      Chef::Log.info "Fixedaddress record not found"
      false
    end
  rescue Exception => e
    Chef::Log.error e.message.split("text\":")[1].chomp('}')
    false
  end  
end

action :create_in_network do
  request_param = {}
  request_param[:name] = new_resource.name
  request_param[:network] = new_resource.network
  request_param[:mac] = new_resource.mac unless new_resource.mac.nil?
  request_param[:ipv4addr] = get_next_ip_address(request_param)
  request_param[:extattrs] = new_resource.extattrs unless new_resource.extattrs.nil?
  record = Infoblox::Fixedaddress.new(connection: connection, ipv4addr: request_param[:ipv4addr])
  record.name = request_param[:name] unless request_param[:name].nil?
  record.mac = request_param[:mac] unless request_param[:mac].nil?
  record.extattrs = request_param[:extattrs] unless request_param[:extattrs].nil?
  begin
    resp = record.post
    Chef::Log.info "Fixedaddress successfully created"
    resp
  rescue Exception => e
    Chef::Log.error e.message.split("text\":")[1].chomp('}')
    false
  end  
end
