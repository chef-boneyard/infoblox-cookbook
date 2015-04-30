module Infoblox
  module Api
    # require 'mixlib'
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
        Chef::Log.info "Record is successfully created."
      rescue
        raise "Something went wrong with Record creation."
      end
    end

    def create_dns_record(params)
      Chef::Log.info "create_dns_record"
      Chef::Log.info "create_host_record"
      record = Infoblox::Host.new(connection: connection, 
                                    ipv4addr: params[:ipv4addr],
                                    name: params[:name])
      begin
        record.post
        Chef::Log.info "Record is successfully created."
      rescue
        raise "Something went wrong with Record creation."
      end
    end

    def create_fixed_address_record(params)
      Chef::Log.info "create_fixed_address_record"
    end

    # def execute_command(cmd)
    #   resp = Mixlib::ShellOut.new(cmd)
    #   resp.run_command
    # end

  end
end