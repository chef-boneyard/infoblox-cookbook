include Infoblox::Api

use_inline_resources

action :reserve_static_ip do
  # validation
  is_valid_ip?(new_resource.ipv4addr) unless new_resource.ipv4addr.nil? 
  request_params = create_request_params

  if new_resource.usage_type.eql?("host")
    request_params[:ipv4addrs] = [{ ipv4addr: new_resource.ipv4addr, mac: new_resource.mac }] 
  else
    request_params[:ipv4addr] = new_resource.ipv4addr unless new_resource.ipv4addr.nil?
    request_params[:mac] = new_resource.mac unless new_resource.mac.nil?
  end
  resp = request(request_params[:usage_type], request_params)
end

action :reserve_network_ip do
  request_params = create_request_params
  # get next available ip address from defined network
  if ip = get_next_ip_address(request_params, new_resource.exclude)
    if new_resource.usage_type.eql?("host")
      request_params[:ipv4addrs] = [{ ipv4addr: ip, mac: new_resource.mac }] 
    else
      request_params[:ipv4addr] = ip
      request_params[:mac] = new_resource.mac unless new_resource.mac.nil?
    end    
    resp = request(request_params[:usage_type], request_params)
  end
end

private

def create_request_params
  request_params = {}
  request_params[:name] = new_resource.name
  request_params[:usage_type] = new_resource.usage_type
  request_params[:view] = new_resource.view unless new_resource.view.nil? 
  request_params[:network] = new_resource.network unless new_resource.network.nil?
  request_params[:network_view] = new_resource.network_view unless new_resource.network_view.nil?
  request_params[:network_container] = new_resource.network_container unless new_resource.network_container.nil?
  request_params[:extattrs] = new_resource.extattrs unless new_resource.extattrs.nil?
  request_params
end
