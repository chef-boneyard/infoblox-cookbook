include Infoblox::Api
use_inline_resources

action :delete do
  request_params = {}
  request_params[:name] = new_resource.name
  request_params[:ipv4addr] = new_resource.ipv4addr unless new_resource.ipv4addr.nil?

  begin
    record = Infoblox::Host.find(connection, request_params)
    unless record.empty?
      record.first.delete
      Chef::Log.info 'Host record successfully deleted'
    else
      Chef::Log.info 'Host record information not found'
      false
    end
  rescue StandardError => e
    Chef::Log.error e.message
    false
  end
end
