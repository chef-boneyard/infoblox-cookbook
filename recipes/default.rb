# Cookbook Name: Infoblox
# Recipe Name: default

require 'chef/provisioning/vsphere_driver'

with_vsphere_driver host: '192.168.100.240',
 insecure: true,
 user:     'rivermeadow',
 password: 'fr3sca'

machine_options = {
     :bootstrap_options => {
       :network_name =>    ["Clogeny-Internal-Net2"],
       :datacenter   =>       'ha-datacenter',
       :host =>             'pun-esx402-01.',
       :resource_pool =>      'pun-esx402-01.',
       :datastore =>         'datastore1',
       :template_name =>   'centos65x86-dhcp-inet2',           # may be a VM or a VM Template
       :vm_folder =>        '/vmfs/volumes/datastore1',
       :customization_spec => {
         :ipsettings => {
           :ip => '10.10.70.11',
           :subnetMask => '255.255.255.0',
           :gateway => ["0.0.0.0"]
         },
         :domain => 'test.local'
       },
       :ssh => {
         :user => 'administrator',
         :password => 'password',
         :paranoid => false,
         :port => 22
       }
     }
 }
 
machine "Test-Machine-1" do
 machine_options machine_options    
end