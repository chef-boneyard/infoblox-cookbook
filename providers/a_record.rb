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
  Chef::Log.info "Action : get IP on the basis of object reference."
  record = Infoblox::Arecord.new(connection: connection, name: request_params[:_ref])
  begin
    record.get.body[0]["ipv4addr"]
  rescue
    raise "Something went wrong while fetching the record or record not found."
  end
end

action :delete do
  request_params = {}
  request_params[:_ref] = new_resource._ref
  Chef::Log.info "Action : delete record on the basis of object reference."

  record = Infoblox::Arecord.new(connection: connection, name: request_params[:_ref])
  begin
    record.delete
  rescue
    raise "Something went wrong while fetching the record or record not found."
  end
end
