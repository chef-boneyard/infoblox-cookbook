default['ptr_record']['name'] = '' # name of record in FQDN format eg. clogeny01.test.local
default['ptr_record']['ipv4addr'] = '' # IPv4 address eg. 10.10.70.100
default['ptr_record']['view'] = 'default' # name of DNS view in which record resides.
default['ptr_record']['ptrdname'] = '' # domain name of DNS PTR record in FQDN format. eg. clogeny.test.local
default['ptr_record']['extattrs'] = {} # extensible attributes associated with the object. eg. { 'Site' => { 'value' => 'Test Value' } }
