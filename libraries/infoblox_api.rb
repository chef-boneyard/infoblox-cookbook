module Infoblox
  module Api

    def connection
      creds = data_bag_item('infoblox', 'credentials') rescue {}
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
          Chef::Log.info 'No IP address available in range'
          return false
        else
          availabe_ip = ips.first
          Chef::Log.info "Next available IP  is : #{availabe_ip}"
          return availabe_ip
        end
      else
        Chef::Log.info 'Range not found.'
        return false
      end
    end

    # get next available ip from network
    def get_next_ip_from_network(network, exclude = [], num = 1)
      network_obj = Infoblox::Network.find(connection, { network: network } )
      unless network_obj.empty?
        ips = network_obj.first.next_available_ip(num, exclude)
        if ips.nil?
          Chef::Log.info 'No IP address available in network'
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

    def create_host_record(params)
      record = Infoblox::Host.new(connection: connection, ipv4addrs: params[:ipv4addrs], name: params[:name])
      record.disable = params[:disable]
      record.aliases = params[:aliases] if params[:aliases]
      record.view = params[:view] if params[:view]
      record.extattrs = params[:extattrs] if params[:extattrs]
      record.comment = params[:comment] if params[:comment]

      begin
        resp = record.post
        Chef::Log.info 'Host record successfully created.'
        return resp
      rescue StandardError => e
        Chef::Log.error e.message
        return false
      end
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
      record.extattrs = params[:extattrs] if params[:extattrs]

      begin
        resp = record.post
        Chef::Log.info "#{record_type} Record is successfully created."
        return resp
      rescue StandardError => e
        Chef::Log.error e.message
        return false
      end
    end

    # create fixedaddress record
    def create_fixedaddress_record(params)
      record = Infoblox::Fixedaddress.new(connection: connection, ipv4addr: params[:ipv4addr])
      record.name = params[:name] if params[:name]
      record.network_view = params[:network_view] if params[:network_view]
      record.network = params[:network] if params[:network]
      record.comment = params[:comment] if params[:comment]
      record.extattrs = params[:extattrs] if params[:extattrs]

      if params[:mac]
        record.mac = params[:mac]
      else
        record.match_client = 'RESERVED'
      end
      
      begin
        resp = record.post
        Chef::Log.info 'Fixed Address Record is successfully created.'
        return resp
      rescue StandardError => e
        Chef::Log.error e.message
        return false
      end
    end

    # remove host record
    def remove_host_record(params)
      search_params = {}
      search_params[:name] = params[:name] if params[:name]
      search_params[:ipv4addr] = params[:ipv4addr] if params[:ipv4addr]
      search_params[:ipv6addr] = params[:ipv6addr] if params[:ipv6addr]
      record = Infoblox::Host.find(connection, search_params)
      begin
        unless record.empty?
          record.first.delete
          Chef::Log.info 'Host record successfully deleted'
          return true
        else
          Chef::Log.info 'Host record information not found'
          return false
        end
      rescue StandardError => e
        Chef::Log.error e.message
        return false
      end
    end

    # remove fixedaddress record
    def remove_fixedaddress_record(params)
      search_params = {}
      search_params[:ipv4addr] = params[:ipv4addr] if params[:ipv4addr]
      search_params[:ipv6addr] = params[:ipv6addr] if params[:ipv6addr]
      record = Infoblox::Fixedaddress.find(connection, search_params).first
      begin
        unless record.nil?
          resp = record.delete
          Chef::Log.info 'Fixedaddress successfully deleted'
          return resp
        else
          Chef::Log.info 'Fixedaddress record not found'
          return false
        end
      rescue StandardError => e
        Chef::Log.error e.message
        return false
      end
    end

    # remove A record
    def remove_a_record(params)
      search_params = {}
      search_params[:name] = params[:name] if params[:name]
      search_params[:ipv4addr] = params[:ipv4addr] if params[:ipv4addr]
      records = Infoblox::Arecord.find(connection, search_params)
      unless records.empty?
        begin
          records.each { |record| record.delete }
          Chef::Log.info 'Arecord(s) successfully deleted'
          return true
        rescue StandardError => e
          Chef::Log.error e.message
          return false
        end
      else
        Chef::Log.info 'Arecord Not Found. Please verify IP address and hostname.'
        return false
      end
    end

    # remove AAAA record
    def remove_aaaa_record(params)
      search_params = {}
      search_params[:name] = params[:name] if params[:name]
      search_params[:ipv6addr] = params[:ipv6addr] if params[:ipv6addr]
      records = Infoblox::AAAArecord.find(connection, search_params)
      unless records.empty?
        begin
          records.each { |record| record.delete }
          Chef::Log.info 'AAAA record(s) successfully deleted'
          return true
        rescue StandardError => e
          Chef::Log.error e.message
          return false
        end
      else
        Chef::Log.info 'AAAA record Not Found. Please verify IP address and hostname.'
        return false
      end
    end

    # remove CNAME record
    def remove_cname_record(params)
      search_params = {}
      search_params[:name] = params[:name] if params[:name]
      search_params[:canonical] = params[:canonical] if params[:canonical]
      records = Infoblox::Cname.find(connection, search_params)
      unless records.empty?
        begin
          records.each { |record| record.delete }
          Chef::Log.info 'Cname Record successfully deleted'
          return true
        rescue StandardError => e
          Chef::Log.error e.message
          return false
        end
      else
        Chef::Log.info 'Cname Record Not Found.'
        return false
      end
    end

    # remove PTR record
    def remove_ptr_record(params)
      search_params = {}
      search_params[:name] = params[:name] if params[:name]
      search_params[:ptrdname] = params[:ptrdname] if params[:ptrdname]
      records = Infoblox::Ptr.find(connection, search_params)
      unless records.empty?
        begin
          records.each { |record| record.delete }
          Chef::Log.info 'Ptr record successfully deleted'
          return true
        rescue StandardError => e
          Chef::Log.error e.message
          return false
        end
      else
        Chef::Log.info 'Ptr record not Found'
        return false
      end
    end

  end
end
