include Infoblox::Api
use_inline_resources

action :create do
  # validation
  valid_ip?(new_resource.ipv4addr)

  # set request params.
  request_params = create_request_params
  create_ptr_record(request_params)
end

action :get_record do
  # validation
  valid_ip?(new_resource.ipv4addr)

  # set request params.
  request_params = {}
  request_params[:name] = new_resource.name unless new_resource.name.nil?
  request_params[:ptrdname] = new_resource.ptrdname unless new_resource.ptrdname.nil?
  request_params[:ipv4addr] = new_resource.ipv4addr unless new_resource.ipv4addr.nil?
  find_ptr_record(request_params)
end

action :delete do
  # validation
  valid_ip?(new_resource.ipv4addr)

  # set request params.
  request_params = {}
  # request_params[:name] = new_resource.name unless new_resource.name.nil?
  request_params[:ptrdname] = new_resource.ptrdname unless new_resource.ptrdname.nil?
  request_params[:ipv4addr] = new_resource.ipv4addr unless new_resource.ipv4addr.nil?
  record = Infoblox::Ptr.find(connection, request_params)
  unless record.empty?
    begin
      resp = record.first.delete
      Chef::Log.info 'Ptr record successfully deleted'
      resp
    rescue StandardError => e
      Chef::Log.error e.message
      false
    end
  else
    Chef::Log.info 'Ptr record not Found'
    false
  end
end

private

def create_request_params
  request_params = {}
  request_params[:name] = new_resource.name
  request_params[:ptrdname] = new_resource.ptrdname
  request_params[:ipv4addr] = new_resource.ipv4addr
  request_params[:view] = new_resource.view unless new_resource.view.nil?
  request_params[:extattrs] = new_resource.extattrs unless new_resource.extattrs.nil?
  request_params
end

def create_ptr_record(params)
  record = Infoblox::Ptr.new(connection: connection, name: params[:name])
  record.ipv4addr = params[:ipv4addr]
  record.extattrs = params[:extattrs]
  record.ptrdname = params[:ptrdname]
  record.view = params[:view]
  begin
    resp = record.post
    Chef::Log.info 'PtrRecord successfully created'
    resp
  rescue StandardError => e
    Chef::Log.error e.message
    false
  end  
end

def find_ptr_record(params)
  record = Infoblox::Ptr.find(connection, params)
  if record.empty?
  	Chef::Log.info "Successfully retrived ptr record"
  	record
  else
  	Chef::Log.info "Ptr Record not found"
  end
end
