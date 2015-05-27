module Infoblox
  module Api

    RECORD_MAPPING = { dns: %w(A AAAA PTR CNAME) }
    USAGE_TYPE = ['host', 'dns', 'fixed_address']

    # IP Validation.
    def valid_ip?(ipaddr)
      IPAddr.new(ipaddr)
    rescue
      raise 'IP address is not valid.'
    end

    def request(params)
      if USAGE_TYPE.include?(params[:usage_type])
        send("create_#{params[:usage_type]}_record", params)
      else
        Chef::Log.error "Please enter valid usage type i.e. fixed_address/host/dns"
      end
    end

    def get_next_ip_address(params, exclude = [], num = 1)
      network_obj = Infoblox::Network.find(connection, network: params[:network])
      unless network_obj.empty?
        ips = network_obj.first.next_available_ip(num, exclude)
        if ips.nil?
          Chef::Log.info 'No IP address available in range/network'
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

    # record specific params DNS/host/fixedaddress
    def set_record_specific_params(new_resource)
      params = {}
      params[:name] = new_resource.name
      # params[:comment] = new_resource.comment  unless new_resource.comment.nil?
      params[:extattrs] = new_resource.extattrs unless new_resource.extattrs.nil?
      params[:usage_type] = new_resource.usage_type
      params[:record_type] = new_resource.record_type

      if params[:usage_type].eql?('host')
        params[:aliases] = new_resource.aliases unless new_resource.aliases.nil?
        params[:device_description] = new_resource.device_description unless new_resource.device_description.nil?
        params[:configure_for_dns] = new_resource.configure_for_dns unless new_resource.configure_for_dns.nil?
      elsif params[:usage_type].eql?('fixed_address')
        params[:network] = new_resource.network unless new_resource.network.nil?
        params[:network_view] = new_resource.network_view unless new_resource.network_view.nil?
      elsif params[:usage_type].eql?('dns')
        params[:view] = new_resource.view unless new_resource.view.nil?
        params[:canonical] = new_resource.canonical unless new_resource.canonical.nil?
        # params[:zone] = new_resource.zone unless new_resource.zone.nil?
        params[:ptrdname ] = new_resource.ptrdname  unless new_resource.ptrdname .nil?
      end
      params
    end

    private

    def create_host_record(params)
      record = Infoblox::Host.new(connection: connection, ipv4addrs: params[:ipv4addrs], name: params[:name])
      record.aliases = params[:aliases] if params[:aliases]
      record.view = params[:view] if params[:view]
      record.extattrs = params[:extattrs] if params[:extattrs]
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
    def create_dns_record(params)
      if RECORD_MAPPING[:dns].include?(params[:record_type])
        if params[:record_type].eql?('A')
          record = Infoblox::Arecord.new(connection: connection, name: params[:name], ipv4addr: params[:ipv4addr])
        elsif params[:record_type].eql?('AAAA')
          record = Infoblox::AAAArecord.new(connection: connection, name: params[:name], ipv6addr: params[:ipv6addr])
        elsif params[:record_type].eql?('PTR')
          record = Infoblox::Ptr.new(connection: connection, name: params[:name], ptrdname: params[:ptrdname])
        elsif params[:record_type].eql?('CNAME')
          record = Infoblox::Cname.new(connection: connection, name: params[:name], canonical: params[:canonical])
        end
        # record.zone = params[:zone] if params[:zone]
        # record.comment = params[:comment] if params[:comment]
        record.disable = params[:disable] if params[:disable]
        record.view = params[:view] if params[:view]
        record.extattrs = params[:extattrs] if params[:extattrs]
        begin
          resp = record.post
          Chef::Log.info 'DNS Record is successfully created.'
          return resp
        rescue StandardError => e
          Chef::Log.error e.message
          return false
        end
      else
        Chef::Log.error "Please enter valid record type for DNS record creation i.e. A/AAAA/PTR/CNAME"
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
        Chef::Log.error e.message
        return false
      end
    end

  end
end
