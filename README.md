Infoblox
=========

The Infoblox cookbook wraps the public APIs available in the "infoblox" gem and is capable of performing the same functions/workflows as the current VMware vRealize Orchestrator adapter. Specifically it does the VM provisioning and de-provisioning operations of vCenter and allows DHCP and DNS configuration to be provided from a centrally managed Infoblox appliance.

Prerequisites
-------------
Configure your Chef workstation setup. The cookbook is tested against Chef version 12.1.1 and above. The OS can be Windows or any Linux machine for the workstation. You need to have a hosted chef account or you can run the recipes in the chef-zero mode as well without having an actual chef server configured. It will Still run the workflows and create records and VMs.

As an environment presetup, You need to have the following configured before using this cookbook. 
1. A single vCenter server host
2. A single vNIOS VM acting as a grid master
3. A chef workstation setup in a VM in the network.
4. DNS and DHCP configured/objects created in the grid master.

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

Recipe: reserve_static_ip
==============================
The following attributes are required while running reserve_static_ip recipe. So provide the values in the file infoblox/attributes/reserve_static_ip.rb

		default['reserve_static_ip']['hostname'] = 'clogeny01.qa.com'
		default['reserve_static_ip']['ipv4addr'] = '172.26.1.52'
		default['reserve_static_ip']['vm_name'] = 'clogeny01' # required for reserve and remove workflows
		default['reserve_static_ip']['record_type'] = ['host']  # or %w(A PTR host fixedaddress)
		
	Optional Attributes:
	  default['reserve_static_ip']['mac'] = ''
		default['reserve_static_ip']['ptrdname'] = 'clogeny01.test.local''
	  default['reserve_static_ip']['canonical'] = 'clogeny1.qa.com'
		default['reserve_static_ip']['extattrs'] = { 'Site' => { 'value' => 'Test Value' } }
		default['reserve_static_ip']['comment'] = "Test Record for Reserve Static IP workflow"
		default['reserve_static_ip']['aliases'] = ['aliases1', 'aliases2']

Recipe: reserve_ip_in_network
=========================================
The following attributes are required while running reserve_ip_in_network recipe. So provide the values in the file infoblox/attributes/reserve_ip_in_network.rb
		default['reserve_ip_in_network']['network'] = '10.10.70.0/24'
		default['reserve_ip_in_network']['record_type'] = %w(A PTR host fixedaddress)
		default['reserve_ip_in_network']['hostname'] = 'clogeny100.test.local'
		default['reserve_ip_in_network']['vm_name'] = 'clogeny100'

	Optional Attributes:
		default['reserve_ip_in_network']['exclude'] = %w(10.10.70.1 10.10.70.2 10.10.70.3) # ips to exclude
		default['reserve_ip_in_network']['ptrdname'] = 'clogeny01.test.local'
		default['reserve_ip_in_network']['aliases'] = ['aliases1', 'aliases2']
		default['reserve_ip_in_network']['canonical'] = 'clogeny01.test.local'
		default['reserve_ip_in_network']['comment'] = "Test Record for Reserve Static IP workflow"
		default['reserve_ip_in_network']['extattrs'] = { 'Site' => { 'value' => 'Test Value' } }
		default['reserve_ip_in_network']['mac'] = ''

	 
Recipe: reserve_ip_in_range
=========================================
The following attributes are required while running reserve_ip_in_range recipe. So provide the values in the file infoblox/attributes/reserve_ip_in_range.rb	 

		default['reserve_ip_in_range']['start_addr'] = '10.10.70.100'
		default['reserve_ip_in_range']['end_addr'] = '10.10.70.220'
		default['reserve_ip_in_range']['record_type'] = %w(A PTR host fixedaddress)
		default['reserve_ip_in_range']['hostname'] = 'clogeny100.test.local'
		default['reserve_ip_in_range']['vm_name'] = 'clogeny100'

	Optional Attributes:
		default['reserve_ip_in_range']['exclude'] = %w(10.10.70.100 10.10.70.101)
		default['reserve_ip_in_range']['ptrdname'] = 'clogeny01.test.local'
		default['reserve_ip_in_range']['aliases'] = ['aliases1', 'aliases2']
		default['reserve_ip_in_range']['canonical'] = 'clogeny01.test.local'
		default['reserve_ip_in_range']['comment'] = "Test Record for Reserve Static IP workflow"
		default['reserve_ip_in_range']['extattrs'] = { 'Site' => { 'value' => 'Test Value' } }
		default['reserve_ip_in_range']['mac'] = ''


Recipe: remove_reserved_ip
=========================================
--The following attributes are required while running remove_reserved_ip recipe. So provide the values in the file infoblox/attributes/remove_reserved_ip.rb

		default['remove_reserved_ip']['vm_name'] = 'clogeny01'
		default['remove_reserved_ip']['hostname'] = 'clogeny01.demo.com'
		default['remove_reserved_ip']['ipv4addr'] = '172.26.1.62'
		default['remove_reserved_ip']['record_type'] = ['host'] #%w(A PTR host fixedaddress)

	Optional Attributes:	
		default['remove_reserved_ip']['ptrdname'] = 'clogeny01.test.local'
		default['remove_reserved_ip']['canonical'] = 'clogeny1.test.local'
		


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