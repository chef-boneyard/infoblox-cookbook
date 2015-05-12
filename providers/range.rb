include Infoblox::Api

action :reserve_ip do
  request_params = {}
  request_params[:start_addr] = new_resource.start_addr
  request_params[:end_addr] = new_resource.end_addr
  request_params[:network_view] = new_resource.network_view unless new_resource.network_view.nil?
  request_params[:network] = new_resource.network unless new_resource.network.nil?
  
  if ip = get_next_ip_from_range(request_params, new_resource.exclude).first
    if new_resource.usage_type.eql?("host")
      request_params[:ipv4addrs] = [{ ipv4addr: ip, mac: new_resource.mac }] 
    else
      request_params[:ipv4addr] = ip
      request_params[:mac] = new_resource.mac unless new_resource.mac.nil?
    end
    request_params[:name] = new_resource.name
    request_params[:extattrs] = new_resource.extattrs unless new_resource.extattrs.nil?
    request_params[:usage_type] = new_resource.usage_type
    resp = request(request_params[:usage_type], request_params)
  else
    Chef::Log.info "Next available IP not found"
  end
end

private

# get next avaialble ip form given range.
def get_next_ip_from_range(params, exclude = [], num = 1)
  range = Infoblox::Range.find(connection, params)
  unless range.empty?
    return range.first.next_available_ip(num, exclude)
  else
    Chef::Log.info "Provided range not found"
    return nil
  end
end
