module Infoblox
  module Api

    require 'ipaddr'
    require 'infoblox'
    require 'pry'
    # IP Validation.
    def is_valid_ip?(ipaddr)
      IPAddr.new(ipaddr) 
    rescue 
      raise "IP address is not valid."
    end

    def request(usage_type, params = {})
      raise "No parameters defined." if params.empty?
      send("create_#{usage_type}_record", params)
    end

    def get_ip_address(params = {})
      raise "No parameters defined." if params.empty?
      record = Infoblox::Network.new(connection: connection, network: params[:network])
      record.network_view = params[:network_view] if params[:network_view]
      record.network_container = params[:network_container] if params[:network_container]
      # TODO
      record.network = get_network_reference(record)
      return record.next_available_ip.first
    end

    private 

    def connection
      @connection ||= Infoblox::Connection.new(username: node[:infoblox][:username], password: node[:infoblox][:password], host: node[:infoblox][:nios])
    end

    def create_host_record(params)
      Chef::Log.info "create_host_record"
      record = Infoblox::Arecord.new(connection: connection)
      record.ipv4addr = params[:ipv4addr] if params[:ipv4addr]
      record.name = params[:name] if params[:name]
      record.view = params[:view] if params[:view]
      begin
        record.post
        Chef::Log.info "Host Record is successfully created."
      rescue
        raise e.message
      end
    end

    def create_dns_record(params)
      record = Infoblox::Host.new(connection: connection)
      record.ipv4addr = params[:ipv4addr] if params[:ipv4addr]
      record.name = params[:name] if params[:name]
      record.view = params[:view] if params[:view]
      begin
        record.post
        Chef::Log.info "DNS Record is successfully created."
      rescue
        raise e.message
      end
    end

    def create_fixed_address_record(params)
      fixedaddr = Infoblox::Fixedaddress.new(connection: connection)
      record.ipv4addr = params[:ipv4addr] if params[:ipv4addr]
      record.name = params[:name] if params[:name]
      record.view = params[:view] if params[:view]
      record.mac = params[:mac_address] if params[:mac_address]
      begin
        fixedaddr.post
        Chef::Log.info "Fixed Address Record is successfully created."
      rescue Exception => e
        raise e.message
      end
    end

    def get_network_reference(network)
      JSON.parse(network.get.body).first["_ref"].gsub("network/", "")
    end

  end
end
