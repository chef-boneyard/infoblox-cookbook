# vSphere host details
default['vm']['host'] = '192.168.100.244'
default['vm']['user'] = 'root'
default['vm']['password'] = 'fr3sca@123'

# provisioned vm details
default['vm']['name'] = 'clogeny002'
default['vm']['guest_id'] = 'centos64Guest'
default['vm']['network'] = 'VM Network'
default['vm']['datacenter'] = 'ha-datacenter'
default['vm']['datastore'] = 'datastore1'
default['vm']['folder_path'] = '/vmfs/volumes/datastore1'
default['vm']['num_cpus'] = 1
default['vm']['memory_mb'] = 128
default['vm']['disk_mode'] = 'persistent'
default['vm']['thin_provisioned'] = true
