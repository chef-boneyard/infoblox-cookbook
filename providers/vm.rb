include Infoblox::Api
use_inline_resources

# provision a new vm on vSphere server.
action :provision do
  Chef::Log.info "Connected to #{fog_connection.vsphere_server} as #{fog_connection.vsphere_username} (API version #{fog_connection.vsphere_rev})"
  begin
    Chef::Log.info 'Deploying new VM from template.  This may take a few minutes...'
    resp = fog_connection.vm_clone(config_options)
    if new_resource.record_type.include?('fixedaddress')
      mac_address = unless new_resource.mac.nil? || new_resource.mac.empty?
                      new_resource.mac
                    else
                      resp['new_vm']['mac_addresses'].call[new_resource.network_adapter]
                    end
      ip = new_resource.ip || node['infoblox']['ip']
      record = Infoblox::Fixedaddress.find(connection, ipv4addr: ip).first
      record.match_client = 'MAC_ADDRESS'
      record.mac = mac_address
      record.put
    end
    sleep(10)
  rescue Exception => e
    Chef::Log.info e.message
  end
end

# remove a vm from vSphere server.
action :deprovision do
  begin
    Chef::Log.info 'Waiting till the VM is powered OFF'
    Chef::Log.info '.' while fog_connection.get_virtual_machine(new_resource.name)['power_state'] != 'poweredOff' 
    vm_info = fog_connection.get_virtual_machine(new_resource.name)
    instance_uuid = vm_info['id']
    if vm_info['power_state'].eql? 'poweredOff'
      fog_connection.vm_destroy('instance_uuid' => instance_uuid)
    else
      Chef::Log.info 'The operation is not allowed in the current state (Powered on)'
    end
  rescue Exception => e
    Chef::Log.error e.message
  end
end

action :power_on do
  begin
    vm_info = fog_connection.get_virtual_machine(new_resource.name)
    instance_uuid = vm_info['id']
    if vm_info['power_state'].eql? 'poweredOff'
      fog_connection.vm_power_on('instance_uuid' => instance_uuid)
      sleep(10)
    else
      Chef::Log.info 'The attempted operation cannot be performed in the current state (Powered on)'
    end
  rescue Exception => e
    Chef::Log.error e.message
  end
end

action :power_off do
  begin
    vm_info = fog_connection.get_virtual_machine(new_resource.name)
    instance_uuid = vm_info['id']
    if vm_info['power_state'].eql? 'poweredOn'
      loop do
        break if vm_info['tools_state'].eql?('toolsOk')
        vm_info = fog_connection.get_virtual_machine(new_resource.name)
      end
      fog_connection.vm_power_off('instance_uuid' => instance_uuid, 'force' => new_resource.force)
      sleep(10)
    else
      Chef::Log.info 'The operation is not allowed in the current state (Powered off)'
    end
  rescue Exception => e
    Chef::Log.error e.message
  end
end

private

# create fog_connection to vcenter server
def fog_connection
  @fog_connection ||= Fog::Compute.new(credentials)
end

# fetch vsphere credentials from data bags
def creds
  @creds ||= data_bag_item('vsphere', 'credentials')
end

# VM clone configration options
def config_options
  {
    'datacenter'    => new_resource.datacenter,
    'template_path' => new_resource.template_path,
    'power_on'      => true,
    'datastore'     => new_resource.datastore,
    'wait'          => true,
    'hostname'      => new_resource.hostname,
    'name'          => new_resource.name,
    'customization_spec' => {
      'domain'     => new_resource.domain,
      'ipsettings' => {
        'ip'             => new_resource.ip || node['infoblox']['ip'],
        'dnsServerList'  => new_resource.dns_server_list,
        'gateway'        => new_resource.gateway,
        'subnetMask'     => new_resource.subnet_mask,
      }
     }
  }
end

# vcenter server credentials params
def credentials
  {
    :provider         => 'vsphere',
    :vsphere_username => creds['username'],
    :vsphere_password => creds['password'],
    :vsphere_server   => creds['hostname'],
    :vsphere_ssl      => true,
    :vsphere_expected_pubkey_hash => creds['pubkey_hash']
  }
end
