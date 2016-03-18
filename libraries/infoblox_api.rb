#
# Author:: Prabhu Das (<prabhu.das@clogeny.com>)
# Author:: Ramesh Sencha (<ramesh.sencha@clogeny.com>)
# Copyright:: Infoblox
# Maintainer:: Infoblox
# License:: Apache License, Version 2.0
#

module Infoblox
  module Api

    def connection
      creds = data_bag_item(node['infoblox']['data_bag_name'], node['infoblox']['data_bag_item']) rescue {}
      @connection ||= Infoblox::Connection.new( username: creds['username'] || node['infoblox']['username'],
                                                password: creds['password'] || node['infoblox']['password'],
                                                host: creds['hostname'] || node['infoblox']['nios_appliance'] )
    end

    # get next avaialble ip form given range.
    def get_next_ip_from_range(start_addr, end_addr, exclude = [], num = 1)
      params = { start_addr: start_addr, end_addr: end_addr}
      range = Infoblox::Range.find(connection, params)
      unless range.empty?
        ips = range.first.next_available_ip(num, exclude)
        if ips.nil?
          raise 'No IP address available in range'
        else
          availabe_ip = ips.first
          Chef::Log.info "Next available IP  is : #{availabe_ip}"
          return availabe_ip
        end
      end
      raise 'Range not found.'
    end

    # get next available ip from network
    def get_next_ip_from_network(network, exclude = [], num = 1)
      network_obj = Infoblox::Network.find(connection, { network: network } )
      unless network_obj.empty?
        ips = network_obj.first.next_available_ip(num, exclude)
        if ips.nil?
          raise 'No IP address available in network'
        else
          availabe_ip = ips.first
          Chef::Log.info "Next available IP  is : #{availabe_ip}"
          return availabe_ip
        end
      end
      raise 'Network not found.'
    end

    def create_host_record(params)
      record = Infoblox::Host.new(connection: connection, ipv4addrs: params[:ipv4addrs], name: params[:name])
      record.disable = params[:disable]
      record.aliases = params[:aliases] if params[:aliases]
      record.view = params[:view] if params[:view]
      record.extensible_attributes = params[:extattrs] if params[:extattrs]
      record.comment = params[:comment] if params[:comment]

      resp = record.post
      Chef::Log.info 'Host record successfully created.'
      return resp
    end

    # create a record based on the record type A/AAAA/CNAME/PTR
    def create_dns_record(params, record_type)
      if record_type.eql?('A')
        record = Infoblox::Arecord.new(connection: connection, name: params[:name], ipv4addr: params[:ipv4addr])
      elsif record_type.eql?('AAAA')
        record = Infoblox::AAAArecord.new(connection: connection, name: params[:name], ipv6addr: params[:ipv6addr])
      elsif record_type.eql?('PTR')
        record = Infoblox::Ptr.new(connection: connection, name: params[:name], ptrdname: params[:ptrdname])
      elsif record_type.eql?('CNAME')
        record = Infoblox::Cname.new(connection: connection, name: params[:name], canonical: params[:canonical])
      end
      record.disable = params[:disable]
      record.comment = params[:comment] if params[:comment]
      record.view = params[:view] if params[:view]
      record.extensible_attributes = params[:extattrs] if params[:extattrs]

      resp = record.post
      Chef::Log.info "#{record_type} Record is successfully created."
      return resp
    end

    # create fixedaddress record
    def create_fixedaddress_record(params)
      record = Infoblox::Fixedaddress.new(connection: connection, ipv4addr: params[:ipv4addr])
      record.name = params[:name] if params[:name]
      record.network_view = params[:network_view] if params[:network_view]
      record.network = params[:network] if params[:network]
      record.comment = params[:comment] if params[:comment]
      record.extensible_attributes = params[:extattrs] if params[:extattrs]

      if params[:mac]
        record.mac = params[:mac]
      else
        record.match_client = 'RESERVED'
      end

      resp = record.post
      Chef::Log.info 'Fixed Address Record is successfully created.'
      return resp
    end

    # create or update host record
    def create_or_update_host_record(params)
      search_params = {}
      search_params[:name] = params[:name].downcase if params[:name]

      record = Infoblox::Host.find(connection, search_params)
      if record.empty?
        create_host_record(params)
      else
        update_host_record(params, record)
      end
      true
    end

    # remove host record
    def remove_host_record(params)
      search_params = {}
      search_params[:name] = params[:name].downcase if params[:name]
      search_params[:ipv4addr] = params[:ipv4addr] if params[:ipv4addr]
      search_params[:ipv6addr] = params[:ipv6addr] if params[:ipv6addr]

      record = Infoblox::Host.find(connection, search_params)
      unless record.empty?
        record.first.delete
        Chef::Log.info 'Host record successfully deleted'
        return true
      end
      raise 'Host record information not found'
    end

    # remove fixedaddress record
    def remove_fixedaddress_record(params)
      search_params = {}
      search_params[:ipv4addr] = params[:ipv4addr] if params[:ipv4addr]
      search_params[:ipv6addr] = params[:ipv6addr] if params[:ipv6addr]

      record = Infoblox::Fixedaddress.find(connection, search_params).first
      unless record.nil?
        resp = record.delete
        Chef::Log.info 'Fixedaddress successfully deleted'
        return resp
      end
      raise 'Fixedaddress record not found'
    end

    # remove A record
    def remove_a_record(params)
      search_params = {}
      search_params[:name] = params[:name].downcase if params[:name]
      search_params[:ipv4addr] = params[:ipv4addr] if params[:ipv4addr]

      records = Infoblox::Arecord.find(connection, search_params)
      unless records.empty?
        records.each { |record| record.delete }
        Chef::Log.info 'Arecord(s) successfully deleted'
        return true
      end
      raise 'Arecord Not Found. Please verify IP address and hostname.'
    end

    # remove AAAA record
    def remove_aaaa_record(params)
      search_params = {}
      search_params[:name] = params[:name] if params[:name]
      search_params[:ipv6addr] = params[:ipv6addr] if params[:ipv6addr]
      records = Infoblox::AAAArecord.find(connection, search_params)
      unless records.empty?
          records.each { |record| record.delete }
          Chef::Log.info 'AAAA record(s) successfully deleted'
          return true
      end
      raise 'AAAA record Not Found. Please verify IP address and hostname.'
    end

    # remove CNAME record
    def remove_cname_record(params)
      search_params = {}
      search_params[:name] = params[:name].downcase if params[:name]
      search_params[:canonical] = params[:canonical] if params[:canonical]
      records = Infoblox::Cname.find(connection, search_params)
      unless records.empty?
        records.each { |record| record.delete }
        Chef::Log.info 'Cname Record successfully deleted'
        return true
      end
      raise 'Cname Record Not Found.'
    end

    # remove PTR record
    def remove_ptr_record(params)
      search_params = {}
      search_params[:name] = params[:name].downcase if params[:name]
      search_params[:ptrdname] = params[:ptrdname] if params[:ptrdname]
      records = Infoblox::Ptr.find(connection, search_params)
      unless records.empty?
        records.each { |record| record.delete }
        Chef::Log.info 'Ptr record successfully deleted'
        return true
      end
      raise 'Ptr record not Found'
    end

    def update_host_record(params, record=nil)
      search_params = {}
      search_params[:name] = params[:name].downcase if params[:name]

      record = Infoblox::Host.find(connection, search_params) unless record

      host = record.first

      # Remove any existing Infoblox::HostIpv4addr
      host.ipv4addrs.clear if params[:replace_ipv4addrs]

      params.each do |key, value|
        case key

        when :replace_ipv4addrs
          # Already handled

        when :extattrs
          host.extensible_attributes = value

        when :ipv4addrs
          # ipv4addrs requires a bit of special effort
          value = params[:ipv4addrs].first
          ipv4addr = value[:ipv4addr]
          mac = value[:mac]

          # Update the MAC attribute of the relevant Infoblox::HostIpv4addr.
          # Note that we cannot set MAC to nil.
          success = false
          unless mac.nil?
            host.ipv4addrs.each do |e|
              if ipv4addr == e.ipv4addr
                e.mac = mac
                success = true
              end
            end
          end

          # If we did not find the ipv4addr on the
          # host, add it now.
          host.ipv4addrs = params[:ipv4addrs] unless success

        else
          host.send("#{key}=", value)
        end
      end

      host.put
    end
  end
end
