Infoblox Cookbook
=========

The Infoblox cookbook wraps the public APIs available in the "infoblox" gem and is capable of performing functions related to provisioning and de-provisioning vCenter server VMs. It also allows DHCP and DNS configuration to be provided from a centrally managed Infoblox appliance. The motive behind the cookbook was the integration of the DDI (DNS, DHCP and IPAM) with the virtual/Cloud provisioning. Currently it is integrated with vSphere. In future it will be available for EC2, openstack and more.

Prerequisites
-------------
Configure your Chef workstation setup. The cookbook is tested against Chef version 12.1.1 and above. The OS can be Windows or any Linux machine as the workstation. The focookbook can be run against any of the 3 types of chef-servers.

1. Hosted chef
2. Private chef-server
3. Chef-zero, without having an actual chef server configured.

In all of the above cases, it will run the workflows and create records and VMs.

As an environment presetup, You need to have the following configured before using this cookbook.

1. A single vCenter server host.
2. A single vNIOS VM acting as a grid master.
3. A chef workstation setup in a VM in the network.
4. DNS and DHCP configured/objects created in the grid master.

Note: While running the chef-client, Please make sure that you have set the environment variable "WAPI_VERSION".

EX: export WAPI_VERSION=1.4.2

Configuration
-------------
In order to communicate with the vCenter API you will have to provide your credentials in the infoblox cokkbooks attributes files.

Ex: In infoblox/attributes/default.rb

		default['vcenter']['vcenter_host'] = ''
		default['vcenter']['username'] = ''
		default['vcenter']['password'] = ''

In order to communicate with the grid master you will have to provide your vNIOS credentials.

		default['infoblox']['nios_appliance'] = '' # ip address of the vNIOS appliance
		default['infoblox']['username'] = ''       # username of the vNIOS appliance
		default['infoblox']['password'] = ''       # password of the vNIOS appliance

VM Specific Configurations
--------------------------
Provide the below details related to the VM that will be provisioned.

Ex: In infoblox/attributes/vm.rb

		default['vcenter']['template_name'] = 'redhat'  #Name of the template/image using which the VM will be cloned
		default['vcenter']['datacenter'] = 'IB'	        #Name of the datacenter
		default['vcenter']['datastore'] = 'datastore1'  #Name of the datastore
		default['vcenter']['domain'] = 'demo.com'	    #Name of the domain for the VM
		default['vcenter']['network_name'] = ["VM Network"]      #Provide in array as shown
		default['vcenter']['gateway'] = ['172.26.1.1']	         #Provide in array as shown
		default['vcenter']['subnet_mask'] = '255.255.255.0'
		default['vcenter']['dns_server_list'] = ['172.26.1.2']   #Provide in array as shown
		default['vcenter']['network_adapter'] = 'Network adapter 1'
		default['vcenter']['resource_pool'] = '172.26.1.4'

		# provisioned VM details
		default['vcenter']['vm']['username'] = 'root'     #Login username for the VM
		default['vcenter']['vm']['password'] = 'xyz'	  #Login password for the VM
		default['vcenter']['vm']['num_cpus'] = 2
		default['vcenter']['vm']['memory_mb'] = 1024

		# override this attributes for next available ip in range and network.
		default['vcenter']['vm']['ipaddress'] = nil


Recipe: reserve_static_ip
==============================
The following attributes are required while running reserve_static_ip recipe. So provide the values in the file infoblox/attributes/reserve_static_ip.rb

		default['reserve_static_ip']['vm_name'] = 'staticVM-3'  # required for reserve and remove workflows
		default['reserve_static_ip']['ipv4addr'] = '172.26.1.52'
		default['reserve_static_ip']['record_type'] = ['host']  # or %w(A PTR host fixedaddress)

	Optional Attributes:
	    default['reserve_static_ip']['mac'] = ''
	    default['reserve_static_ip']['view'] = 'default'
		default['reserve_static_ip']['ptrdname'] = 'clogeny01.test.local''
	    default['reserve_static_ip']['canonical'] = 'clogeny1.qa.com'
		default['reserve_static_ip']['extattrs'] = { 'Site' => { 'value' => 'Test Value' } }
		default['reserve_static_ip']['comment'] = "Test Record for Reserve Static IP workflow"
		default['reserve_static_ip']['aliases'] = ['aliases1', 'aliases2']
		default['reserve_static_ip']['disable'] = false

Recipe: reserve_ip_in_network
=========================================
The following attributes are required while running reserve_ip_in_network recipe. So provide the values in the file infoblox/attributes/reserve_ip_in_network.rb

		default['reserve_ip_in_network']['vm_name'] = 'networkVM-3'
		default['reserve_ip_in_network']['network'] = '10.10.70.0/24'
		default['reserve_ip_in_network']['record_type'] = ['A', 'PTR', 'host', 'fixedaddress']

	Optional Attributes:
		default['reserve_ip_in_network']['exclude'] = ['10.10.70.1', '10.10.70.2', '10.10.70.3'] # ips to exclude
		default['reserve_ip_in_network']['ptrdname'] = 'clogeny01.test.local'
		default['reserve_ip_in_network']['aliases'] = ['aliases1', 'aliases2']
		default['reserve_ip_in_network']['canonical'] = 'clogeny01.test.local'
		default['reserve_ip_in_network']['comment'] = "Test Record for Reserve Static IP workflow"
		default['reserve_ip_in_network']['extattrs'] = { 'Site' => { 'value' => 'Test Value' } }
		default['reserve_ip_in_network']['mac'] = ''
		default['reserve_ip_in_range']['view'] = 'default'
		default['reserve_ip_in_range']['disable'] = false


Recipe: reserve_ip_in_range
=========================================
The following attributes are required while running reserve_ip_in_range recipe. So provide the values in the file infoblox/attributes/reserve_ip_in_range.rb

		default['reserve_ip_in_range']['vm_name'] = 'rangeVM-3'
		default['reserve_ip_in_range']['start_addr'] = '10.10.70.100'
		default['reserve_ip_in_range']['end_addr'] = '10.10.70.220'
		default['reserve_ip_in_range']['record_type'] = ['A', 'PTR', 'host', 'fixedaddress']


	Optional Attributes:
		default['reserve_ip_in_range']['exclude'] = ['10.10.70.100', '10.10.70.101']
		default['reserve_ip_in_range']['ptrdname'] = 'clogeny01.test.local'
		default['reserve_ip_in_range']['aliases'] = ['aliases1', 'aliases2']
		default['reserve_ip_in_range']['canonical'] = 'clogeny01.test.local'
		default['reserve_ip_in_range']['comment'] = "Test Record for Reserve Static IP workflow"
		default['reserve_ip_in_range']['extattrs'] = { 'Site' => { 'value' => 'Test Value' } }
		default['reserve_ip_in_range']['mac'] = ''
		default['reserve_ip_in_range']['view'] = 'default'
		default['reserve_ip_in_range']['disable'] = false


Recipe: remove_reserved_ip
=========================================
--The following attributes are required while running remove_reserved_ip recipe. So provide the values in the file infoblox/attributes/remove_reserved_ip.rb

		default['remove_reserved_ip']['vm_name'] = 'clogeny01'
		default['remove_reserved_ip']['ipv4addr'] = '172.26.1.62'
		default['remove_reserved_ip']['record_type'] = ['host'] # %w(A PTR host fixedaddress)

	Optional Attributes:
		default['remove_reserved_ip']['ptrdname'] = 'clogeny01.test.local'
		default['remove_reserved_ip']['canonical'] = 'clogeny1.test.local'


Creating A specific Record without provisioning VM
--------------------------------------------------

Here we show only for PTR record. Other records can be created just by setting their attribute values and running their recipes.

The following attributes are required while Creating a PTR record. So provide the values in the file infoblox/attributes/ptr_record.rb

	- If the IP Address belongs to a reverse-mapped authoratative zone
		default['ptr_record']['ipv4addr'] = '' # IPv4 address eg. 10.10.70.100
		default['ptr_record']['ptrdname'] = '' # domain name of DNS PTR record in FQDN format. eg. clogeny.test.local

	- If the IP doesn't belong to a reverse-mapped authoratative zone
		default['ptr_record']['name'] = '' # name of record in FQDN format eg. infoblox01.test.local
		default['ptr_record']['ptrdname'] = '' # domain name of DNS PTR record in FQDN format. eg. clogeny.test.local

	Optional Attributes:
	  default['ptr_record']['view'] = 'default' # name of DNS view in which record resides.
    default['ptr_record']['extattrs'] = {}

Support
=======

This cookbook is a joint effort between Chef and Infoblox.

Chef customers experiencing a technical issue with this cookbook should open a support ticket for assistance.  All other users should feel free to log a GitHub issue in this repository.

For non-technical inquiries regarding this cookbook, please log a GitHub issue, or send an email to one of the following addresses:

 * Chef: partnereng@chef.io
 * Infoblox: chef-support@infoblox.com


License
=======

Copyright:: Copyright (c) 2015 Chef Software, Inc.

License:: Apache License, Version 2.0

Licensed under the Apache License, Version 2.0 (the "License"); you may not use
this file except in compliance with the License. You may obtain a copy of the License at

```
http://www.apache.org/licenses/LICENSE-2.0
```

Unless required by applicable law or agreed to in writing, software distributed under the
License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
either express or implied. See the License for the specific language governing permissions
and limitations under the License.


Contributing
============

1. Fork it ( https://github.com/chef-partners/infoblox-cookbook/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
