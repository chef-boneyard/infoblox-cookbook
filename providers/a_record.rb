include Infoblox::Api

action :create do
  # validation
  is_valid_ip?(new_resource.ipv4addr)    

  # set request params.
  request_params = {}
  request_params[:name] = new_resource.name
  request_params[:ipv4addr] = new_resource.ipv4addr
  request_params[:view] = new_resource.view unless new_resource.view.nil? 

  resp = create_a_record(request_params)
end

action :get_record do
  request_params = {}
  request_params[:name] = new_resource.name
  Chef::Log.info "Action : get_record on the basis of hostname/FQDN"
  
  begin
    record = Infoblox::Arecord.find(connection, name: request_params[:name])
    unless record.empty?
       Chef::Log.info "Arecord information retrieved successfully"
    else
       Chef::Log.info "Arecord information not found"
    end
  rescue StandardError => e
    unless e.message.match(/Client.Ibap.Proto/)
      Chef::Log.error "Invalid Request"
    else
      raise "Something went wrong while fetching the record"
    end
  end
end

action :get_ip do
  Chef::Log.info "Action : get IP on the basis of object reference/hostname/ipv4address."
  request_params = {}
  request_params[:name] = new_resource.name unless new_resource.name.nil?
  request_params[:ipv4addr] = new_resource.ipv4addr unless new_resource.ipv4addr.nil?
  request_params[:record_ref] = new_resource.record_ref unless new_resource.record_ref.nil?

  begin
    ips = []
    unless request_params[:record_ref].nil?
      record = JSON.parse(Infoblox::Arecord.new(connection: connection).get.body)
      a_record = record.select{ |ref| ref["_ref"].match(request_params[:record_ref]) }
      a_record.each{ |record| ips << record["ipv4addr"] }
    else
      Infoblox::Arecord.find(connection, request_params).each{ |record| ips << record.ipv4addr}
    end
    unless ips.empty?
      Chef::Log.info "A-record IP information successfully retrieved"
    else
      Chef::Log.info "A-record IP not found"
    end
  rescue StandardError => e
    unless e.message.match(/Client.Ibap.Proto/)
      Chef::Log.error "Invalid Request"
    else
      raise "Something went wrong while fetching the record or record not found."
    end
  end
end

action :delete do
  Chef::Log.info "Action : delete record on the basis of IP address."
  request_params = create_a_record_params(new_resource)
  delete_a_record(request_params)
end

private

# delete A-record
def delete_a_record(params)
  a_record_obj = Infoblox::Arecord.find(connection, params)
  unless a_record_obj.empty?
    begin
      a_record_obj.first.delete
      Chef::Log.info "Arecord successfully deleted"
    rescue Exception => e
      Chef::Log.error e.message
    end
  else
    Chef::Log.info "Arecord Not Found. Please verify IP address and hostname."
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
  begin
    record.post
    Chef::Log.info "A-record successfully created."
  rescue Exception => e
    unless e.message.match(/Client.Ibap.Data.Conflict/).nil?
      Chef::Log.info "A-record already exists, Please select another A-record."
    else
      raise e.message
    end
  end
end
