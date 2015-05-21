#!/usr/bin/ruby
require 'rbvmomi'
require 'rubygems'
require 'fog'

VIM = RbVmomi::VIM
# provision a new vm on vSphere server.
action :provision do
  clone_vm
end

# remove a vm from vSphere server.
action :deprovision do
  connection = Fog::Compute.new(credentials)
  connection.vm_destroy('instance_uuid' => new_resource.instance_uuid)
end

action :power_on do
  connection = Fog::Compute.new(credentials)
  connection.vm_power_on('instance_uuid' => new_resource.instance_uuid)
end

action :power_off do
  connection = Fog::Compute.new(credentials)
  connection.vm_power_off('instance_uuid' => new_resource.instance_uuid)
end

private

# host connection
def vim
  @vim ||= RbVmomi::VIM.connect host: new_resource.host, user: new_resource.user, password: new_resource.password, insecure: true
end

# datacenter
def dc
  @dc ||= vim.serviceInstance.find_datacenter(new_resource.datacenter) or abort "Datacenter not found"
end

def clone_vm
  connection = Fog::Compute.new(credentials)
  Chef::Log.info "Connected to #{connection.vsphere_server} as #{connection.vsphere_username} (API version #{connection.vsphere_rev})"
  Chef::Log.info "Deploying new VM from template.  This may take a few minutes..."
  new_vm = connection.vm_clone(config_options)
end

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
        'ip'      => new_resource.ip,
        'gateway' => new_resource.gateway,
        'subnetMask' => new_resource.subnet_mask,
      },
     }
  }
end

def credentials
  {
    :provider         => "vsphere",
    :vsphere_username => new_resource.user,
    :vsphere_password => new_resource.password,
    :vsphere_server   => new_resource.host,
    :vsphere_ssl      => true,
    :vsphere_expected_pubkey_hash => new_resource.pubkey_hash
  }
end
