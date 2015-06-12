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

Configuration
-------------
In order to communicate with the vCenter API you will have to provide your credentials in the infoblox cokkbooks attributes files.

Ex: In infoblox/attributes/default.rb
		default['infoblox']['host'] = ''
		default['infoblox']['nios'] = ''
		default['infoblox']['username'] = ''
		default['infoblox']['password'] = ''
		default['infoblox']['version'] = ''

Recipe: reserve_ip_for_vcac_vm
==============================
--The following attributes are required while running reserve_ip_for_vcac_vm recipe. So provide the values in the file infoblox/attributes/vcac_vm.rb

		default['vcac_vm_static_ip']['name'] = 'clogeny02'
		default['vcac_vm_static_ip']['ipv4addr'] = '10.10.70.2'
		default['vcac_vm_static_ip']['hostname'] = 'clogeny02.poc.infobloxdemo.com'
		default['vcac_vm_static_ip']['usage_type'] = 'dns'
		default['vcac_vm_static_ip']['record_type'] = 'A'

	Optional Attributes:
	  default['vcac_vm_static_ip']['mac'] = ''
		default['vcac_vm_static_ip']['ptrdname'] = ''
	  default['vcac_vm_static_ip']['canonical'] = ''
		default['vcac_vm_static_ip']['extattrs'] = { 'Site' => { 'value' => 'Test Value' } }
		default['vcac_vm_static_ip']['comment'] = 'Test record for reserve static IP'

Recipe: reserve_ip_for_vcac_vm_in_network
=========================================
--The following attributes are required while running reserve_ip_for_vcac_vm_in_network recipe. So provide the values in the file infoblox/attributes/vcac_vm.rb
		default['vcac_vm_network_ip']['name'] = 'clogeny12'
		default['vcac_vm_network_ip']['hostname'] = 'clogeny12.demo.com'
		default['vcac_vm_network_ip']['mac'] = ''
		default['vcac_vm_network_ip']['network'] = '172.26.1.0/24'
		default['vcac_vm_network_ip']['exclude'] = %w(10.10.70.1 10.10.70.2) #provide the IPs to exclude from being available in the shown format
		default['vcac_vm_network_ip']['ptrdname'] = '' # domain name of DNS PTR record in FQDN format. eg. clogeny.test.local
		default['vcac_vm_network_ip']['canonical'] = '' 

		default['vcac_vm_network_ip']['usage_type'] = 'host'
		default['vcac_vm_network_ip']['record_type'] = 'A'
	 
Recipe: reserve_ip_for_vcac_vm_in_range
=========================================
--The following attributes are required while running reserve_ip_for_vcac_vm_in_range recipe. So provide the values in the file infoblox/attributes/vcac_vm.rb	 

		default['vcac_vm_range_ip']['name'] = 'clogeny13'
		default['vcac_vm_range_ip']['hostname'] = 'clogeny13.poc.infobloxdemo.com'
		default['vcac_vm_range_ip']['mac'] = ''
		default['vcac_vm_range_ip']['start_addr'] = '172.26.1.1'
		default['vcac_vm_range_ip']['end_addr'] = '172.26.1.60'
		default['vcac_vm_range_ip']['exclude'] = ''  # provide in array as shown here  %w(172.26.1.1 172.26.1.2)
		default['vcac_vm_range_ip']['ptrdname'] = ''
		default['vcac_vm_range_ip']['canonical'] = ''
		default['vcac_vm_range_ip']['usage_type'] = 'dns'
		default['vcac_vm_range_ip']['record_type'] = 'A'

Recipe: remove_host_record_for_vcac_vm
=========================================
--The following attributes are required while running remove_host_record_for_vcac_vm recipe. So provide the values in the file infoblox/attributes/vcac_vm.rb

#TODO


--The following attributes are required while Creating a PTR record. So provide the values in the file infoblox/attributes/ptr_record.rb 

	- If the IP Address belongs to a reverse-mapped authoratative zone 
		default['ptr_record']['ipv4addr'] = '' # IPv4 address eg. 10.10.70.100
		default['ptr_record']['ptrdname'] = '' # domain name of DNS PTR record in FQDN format. eg. clogeny.test.local

	- If the IP doesn't belong to a reverse-mapped authoratative zone 
		default['ptr_record']['name'] = '' # name of record in FQDN format eg. infoblox01.test.local
		default['ptr_record']['ptrdname'] = '' # domain name of DNS PTR record in FQDN format. eg. clogeny.test.local

	Optional Attributes:
	  default['ptr_record']['view'] = 'default' # name of DNS view in which record resides.
    default['ptr_record']['extattrs'] = {}