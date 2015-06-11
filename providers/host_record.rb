include Infoblox::Api
use_inline_resources

action :delete do
  request_params = {}
  request_params[:name] = new_resource.name
  request_params[:ipv4addr] = new_resource.ipv4addr unless new_resource.ipv4addr.nil?

  remove_host_record(request_params)
end
