include Infoblox::Api

action :create do

  # validation
  is_valid_ip?(new_resource.ipv4addr)    

  # set request params.
  request_params = {}
  request_params[:name] = new_resource.name
  request_params[:ipv4addr] = new_resource.ipv4addr
  request_params[:view] = new_resource.view unless new_resource.view.nil? 

  resp = create_host_record(request_params)
end

action :get_record do
  request_params = {}
  request_params[:name] = new_resource.name
  Chef::Log.info "Action : get_record on the basis of hostname/FQDN"
  Infoblox::Arecord.wapi_object = request_params[:name]
  record = Infoblox::Arecord.new(connection: connection, name: request_params[:name])
  begin
    record.get
  rescue
    raise "Something went wrong while fetching the record or record not found."
  end
end

action :get_ip do
  request_params = {}
  request_params[:_ref] = new_resource._ref
  binding.pry
  Chef::Log.info "Action : get IP on the basis of object reference."
  Infoblox::Arecord.wapi_object = request_params[:name]
  record = Infoblox::Arecord.new(connection: connection, name: request_params[:_ref])
  
  binding.pry
  begin
    record.get.body[0]["ipv4addr"]
  rescue
    raise "Something went wrong while fetching the record or record not found."
  end
end

action :delete do
  Chef::Log.info "Action : delete record on the basis of IP address."
  request_params = create_a_record_params(new_resource)
  delete_a_record(request_params)
end

# delete A-record
def delete_a_record(params)
  a_record_obj = Infoblox::Arecord.find(connection, ipv4addr: params[:name])
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
  request_params
end
