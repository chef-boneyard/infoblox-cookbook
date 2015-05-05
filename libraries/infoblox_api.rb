module Infoblox
  module Api

    require 'ipaddr'
    require 'infoblox'

    # IP Validation.
    def is_valid_ip?(ipaddr)
      IPAddr.new(ipaddr) 
    rescue 
      raise "IP address is not valid."
    end

    def request(usage_type, params = {})
      raise "No parameters defined." if params.empty?
      send("create_#{usage_type}_record",params)
    end

    def get_ip_address(params = {})
      raise "No parameters defined." if params.empty?
      Chef::Log.info "get_ip_address"
      record = Infoblox::Netowk.new(connection: connection, params)
      return record.next_available_ip
    end

    private 

    def connection
      @connection ||= Infoblox::Connection.new(username: node[:infoblox][:username], password: node[:infoblox][:password], host: node[:infoblox][:nios])
    end

    def create_host_record(params)
      Chef::Log.info "create_host_record"
      record = Infoblox::Arecord.new(connection: connection, 
                                    ipv4addr: params[:ipv4addr],
                                    name: params[:name],
                                    view: params[:view])
      begin
        record.post
        Chef::Log.info "Host Record is successfully created."
      rescue
        raise e.message
      end
    end

    def create_dns_record(params)
      record = Infoblox::Host.new(connection: connection, 
                                    ipv4addr: params[:ipv4addr],
                                    name: params[:name])
      begin
        record.post
        Chef::Log.info "DNS Record is successfully created."
      rescue
        raise e.message
      end
    end

    def create_fixed_address_record(params)
      begin
        fixedaddr = Infoblox::Fixedaddress.new(connection: connection,
                                            ipv4addr: params[:ipv4addr],
                                            mac: params[:mac_address])
        fixedaddr.post
        Chef::Log.info "Fixed Address Record is successfully created."
      rescue Exception => e
        raise e.message
      end
    end

  end
end
