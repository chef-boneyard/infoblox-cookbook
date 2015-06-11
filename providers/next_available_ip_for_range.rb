include Infoblox::Api
use_inline_resources

action :find do
  request_params = {}
  request_params[:start_addr] = new_resource.start_addr
  request_params[:end_addr] = new_resource.end_addr
  exclude = new_resource.exclude || []
  ip = get_next_ip_from_range(request_params, exclude)
  node.override!['infoblox']['ip'] = ip
end

private

# get next avaialble ip form given range.
def get_next_ip_from_range(params, exclude = [], num = 1)
  range = Infoblox::Range.find(connection, params)
  unless range.empty?
    ips = range.first.next_available_ip(num, exclude)
    if ips.nil?
      Chef::Log.info 'No IP address available in range'
      return nil
    else
      availabe_ip = ips.first
      Chef::Log.info "Next available IP  is : #{availabe_ip}"
      return availabe_ip
    end
  else
    Chef::Log.info 'Range not found.'
    return nil
  end
end
