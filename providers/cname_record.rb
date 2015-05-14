include Infoblox::Api
use_inline_resources

action :create do
  request_params = {}
  request_params[:name] = new_resource.name
  request_params[:canonical] = new_resource.canonical
  request_params[:comment] = new_resource.comment unless new_resource.comment.nil?
  request_params[:disable] = new_resource.disable unless new_resource.disable.nil?
  request_params[:extattrs] = new_resource.extattrs unless new_resource.extattrs.nil?
  create_cname_record(request_params)
end

action :delete do
  request_params = {}
  request_params[:name] = new_resource.name
  request_params[:canonical] = new_resource.canonical
  delete_cname_record(request_params)
end

action :get_cname_record_info do
  request_params = {}
  request_params[:name] = new_resource.name
  request_params[:canonical] = new_resource.canonical
  record = find_cname_record(request_params)
  unless record.empty?
    resp = record.first
    Chef::Log.info 'Successfully retrived CNAME record.'
    resp
  else
    Chef::Log.info 'CNAME record not found.'
    false
  end
end

# create cname-record
def create_cname_record(params)
  record = Infoblox::Cname.new(connection: connection, name: params[:name], canonical: params[:canonical])
  record.comment = params[:comment] if params[:comment]
  record.disable = params[:disable] if params[:disable]
  record.extattrs = params[:extattrs] if params[:extattrs]
  begin
    resp = record.post
    Chef::Log.info 'cname-record successfully created.'
    return resp
  rescue StandardError => e
    Chef::Log.error e.message
    return false
  end
end

# delete cname-record
def delete_cname_record(params)
  cname_record_obj = find_cname_record(params)
  unless cname_record_obj.empty?
    begin
      resp = cname_record_obj.first.delete
      Chef::Log.info 'Cname Record successfully deleted'
      return resp
    rescue StandardError => e
      Chef::Log.error e.message
      return false
    end
  else
    Chef::Log.info 'Cname Record Not Found. Please verify name and canonical name.'
    return false
  end
end

def find_cname_record(params)
  Infoblox::Cname.find(connection, name: params[:name], canonical: params[:canonical])
end
