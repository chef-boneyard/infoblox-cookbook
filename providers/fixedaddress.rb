include Infoblox::Api

action :create do
  request_param = {}
  request_param[:name] = new_resource.name
  request_param[:ipv4addr] = new_resource.ipv4addr
  request_param[:mac] = new_resource.mac unless new_resource.mac.nil?

  record = Infoblox::Fixedaddress.new(connection: connection, ipv4addr: request_param[:ipv4addr])
  record.name = request_param[:name] unless request_param[:name].nil?
  record.mac = request_param[:mac] unless request_param[:mac].nil?

  begin
    Chef::Log.info "Fixedaddress successfully created"
    record.post
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
    end
  rescue Exception => e
    Chef::Log.error e.message.split("text\":")[1].chomp('}')
  end  
end

action :remove do
  request_param = {}
  request_param[:ipv4addr] = new_resource.ipv4addr
  record = Infoblox::Fixedaddress.find(connection, request_param).first
  begin
    unless record.nil?
      Chef::Log.info "Fixedaddress successfully deleted"
      record.delete
    else
      Chef::Log.info "Fixedaddress record not found"
    end
  rescue Exception => e
    Chef::Log.error e.message.split("text\":")[1].chomp('}')
  end  
end

action :create_in_network do
  request_param = {}
  request_param[:name] = new_resource.name
  request_param[:network] = new_resource.network
  request_param[:mac] = new_resource.mac unless new_resource.mac.nil?
  request_param[:ipv4addr] = get_next_ip_address(request_param)
  record = Infoblox::Fixedaddress.new(connection: connection, ipv4addr: request_param[:ipv4addr])
  record.name = request_param[:name] unless request_param[:name].nil?
  record.mac = request_param[:mac] unless request_param[:mac].nil?
  begin
    Chef::Log.info "Fixedaddress successfully created"
    record.post
  rescue Exception => e
    Chef::Log.error e.message.split("text\":")[1].chomp('}')
  end  
end
