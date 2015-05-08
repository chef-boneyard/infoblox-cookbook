include Infoblox::Api

action :create do
  request_params = {}
  request_params[:name] = new_resource.name
  request_params[:canonical] = new_resource.canonical
  request_params[:comment] = new_resource.comment unless new_resource.comment.nil?
  request_params[:disable] = new_resource.disable unless new_resource.disable.nil? 

  resp = create_cname_record(request_params)
end

action :delete do
  request_params = {}
  request_params[:name] = new_resource.name
  request_params[:canonical] = new_resource.canonical
  delete_cname_record(request_params)
end

# create cname-record
def create_cname_record(params)
  record = Infoblox::Cname.new(connection: connection, name: params[:name], canonical: params[:canonical])
  record.comment = params[:comment] if params[:comment]
  record.disable = params[:disable] if params[:disable]

  begin
    record.post
    Chef::Log.info "cname-record successfully created."
  rescue Exception => e
    unless e.message.match(/Client.Ibap.Data.Conflict/).nil?
      Chef::Log.info "cname-record already exists, Please select another cname-record."
    else
      raise e.message
    end
  end
end

# delete cname-record
def delete_cname_record(params)
  cname_record_obj = Infoblox::Cname.find(connection, name: params[:name], canonical: params[:canonical])
  unless cname_record_obj.empty?
    begin
      cname_record_obj.first.delete
      Chef::Log.info "Cname Record successfully deleted"
    rescue Exception => e
      Chef::Log.error e.message
    end
  else
    Chef::Log.info "Cname Record Not Found. Please verify name and canonical name."
  end
end