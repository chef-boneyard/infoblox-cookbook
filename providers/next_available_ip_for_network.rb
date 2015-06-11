include Infoblox::Api
use_inline_resources

action :find do
  request_params = {}
  request_params[:network] = new_resource.network
  exclude = new_resource.exclude || []
  ip = get_next_ip_from_network(request_params, exclude)
  node.override!['infoblox']['ip'] = ip
end

private

# get next available ip from network
def get_next_ip_from_network(params, exclude = [], num = 1)
  network_obj = Infoblox::Network.find(connection, params)
  unless network_obj.empty?
    ips = network_obj.first.next_available_ip(num, exclude)
    if ips.nil?
      Chef::Log.info 'No IP address available in network'
      return nil
    else
      availabe_ip = ips.first
      Chef::Log.info "Next available IP  is : #{availabe_ip}"
      return availabe_ip
    end
  else
    Chef::Log.info 'Network not found.'
    return false
  end
end
