require 'rbvmomi'
require 'pry'

VIM = RbVmomi::VIM
# provision a new vm on vSphere server.
action :provision do
  vmFolder = dc.vmFolder
  hosts = dc.hostFolder.children
  rp = hosts.first.resourcePool
  vmFolder.CreateVM_Task(:config => config_object, :pool => rp).wait_for_completion
end

# remove a vm from vSphere server.
action :deprovision do
  vm = dc.find_vm(new_resource.name) or fail "VM not found"
  vm.Destroy_Task.wait_for_completion
end

action :power_on do
  vm = dc.find_vm(new_resource.name) or fail "VM not found"
  vm.PowerOnVM_Task.wait_for_completion
end

action :power_off do
  vm = dc.find_vm(new_resource.name) or fail "VM not found"
  vm.PowerOffVM_Task.wait_for_completion
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


# { :adapter => VIM.CustomizationIPSettings( :ip => '10.10.70.12' ) }

def config_object
  config = {
  :name => new_resource.name,
  :guestId => new_resource.guest_id,
  :files => { :vmPathName => "[#{new_resource.datastore}]" },
  :numCPUs => new_resource.num_cpus,
  :memoryMB => new_resource.memory_mb,
  :customization_spec => {
	:ipsettings => {
	  :ip => '10.10.70.3',
	  :subnetMask => '255.255.255.0'
	}
  },
  :deviceChange => 
  [
    {
     :operation => :add,
     :device => VIM.VirtualLsiLogicController(
       :key => 1000,
       :busNumber => 0,
       :sharedBus => :noSharing
     )
   }, 
   {
      :operation => :add,
      :fileOperation => :create,
      :device => VIM.VirtualDisk(
        :key => 0,
        :backing => VIM.VirtualDiskFlatVer2BackingInfo(
          :fileName => "[#{new_resource.datastore}]",
          :diskMode => new_resource.disk_mode.to_sym,
          :thinProvisioned => new_resource.thin_provisioned,
        ),
        :controllerKey => 1000,
        :unitNumber => 0,
        :capacityInKB => 4000000
      )
    }, 
    {
      :operation => :add,
      :device => VIM.VirtualE1000(
        :key => 0,
        :deviceInfo => {
          :label => 'Network Adapter 1',
          :summary => new_resource.network
        },
        :backing => VIM.VirtualEthernetCardNetworkBackingInfo(
          :deviceName => new_resource.network
        ),
        :addressType => 'generated'
      )
    }
  ]
 }
end
