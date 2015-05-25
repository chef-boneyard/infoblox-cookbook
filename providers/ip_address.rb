include Infoblox::Api
use_inline_resources

action :reserve_static_ip do
  request_params = set_record_specific_params(new_resource)
  if request_params[:usage_type].eql?('host')
    request_params[:ipv4addrs] = [{ ipv4addr: new_resource.ipv4addr, mac: new_resource.mac }]
  else
    request_params[:ipv4addr] = new_resource.ipv4addr unless new_resource.ipv4addr.nil?
    request_params[:mac] = new_resource.mac unless new_resource.mac.nil?
  end
  request(request_params)
end

action :reserve_network_ip do
  request_params = set_record_specific_params(new_resource)
  request_params[:network] = new_resource.network unless new_resource.network.nil?
  request_params[:network_view] = new_resource.network_view unless new_resource.network_view.nil?
  request_params[:network_container] = new_resource.network_container unless new_resource.network_container.nil?
  # get next available ip address from defined network
  if ip = get_next_ip_address(request_params, new_resource.exclude)
    if new_resource.usage_type.eql?('host')
      request_params[:ipv4addrs] = [{ ipv4addr: ip, mac: new_resource.mac }]
    else
      request_params[:ipv4addr] = ip
      request_params[:mac] = new_resource.mac unless new_resource.mac.nil?
    end
    node.override!['vcac_vm']['ip'] = ip if request(request_params)
  end
end
