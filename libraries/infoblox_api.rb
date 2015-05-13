module Infoblox
  module Api

    require 'ipaddr'
    require 'infoblox'

    # IP Validation.
    def valid_ip?(ipaddr)
      IPAddr.new(ipaddr)
    rescue
      raise 'IP address is not valid.'
    end

    def request(usage_type, params = {})
      send("create_#{usage_type}_record", params)
    end

    def get_next_ip_address(params, exclude = [], num = 1)
      network_obj = Infoblox::Network.find(connection, network: params[:network])
      unless network_obj.empty?
        ips = network_obj.first.next_available_ip(num, exclude)
        if ips.nil?
          Chef::Log.info 'There are no availble IP address.'
          return false
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

    def connection
      @connection ||= Infoblox::Connection.new(username: node['infoblox']['username'], password: node['infoblox']['password'], host: node['infoblox']['nios'])
    end

    private

    def create_host_record(params)
      record = Infoblox::Host.new(connection: connection, ipv4addrs: params[:ipv4addrs], name: params[:name])
      record.view = params[:view] if params[:view]
      record.extattrs = params[:extattrs] if params[:extattrs]
      begin
        resp = record.post
        Chef::Log.info 'Host record successfully created.'
        return resp
      rescue StandardError => e
        Chef::Log.error e.message.split('text\':')[1].chomp('}')
        return false
      end
    end

    def create_dns_record(params)
      record = Infoblox::Arecord.new(connection: connection, name: params[:name], ipv4addr: params[:ipv4addr])
      record.view = params[:view] if params[:view]
      record.extattrs = params[:extattrs] if params[:extattrs]
      begin
        resp = record.post
        Chef::Log.info 'DNS Record is successfully created.'
        return resp
      rescue StandardError => e
        Chef::Log.error e.message.split('text\':')[1].chomp('}')
        return false
      end
    end

    def create_fixed_address_record(params)
      record = Infoblox::Fixedaddress.new(connection: connection, ipv4addr: params[:ipv4addr])
      record.name = params[:name] if params[:name]
      record.view = params[:view] if params[:view]
      record.mac = params[:mac] if params[:mac]
      record.extattrs = params[:extattrs] if params[:extattrs]
      begin
        resp = record.post
        Chef::Log.info 'Fixed Address Record is successfully created.'
        return resp
      rescue StandardError => e
        Chef::Log.error e.message.split('text\':')[1].chomp('}')
        return false
      end
    end

  end
end
