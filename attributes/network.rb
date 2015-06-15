# network attributes
default['network']['subnet'] = '' # network address, in IPv4 address/CIDR foramt. eg. '10.10.70.0/24'
default['network']['network_ref'] = '' # valid network object reference EX: ZG5zLm5ldHdvcmskMTAuMTAuNzAuMC8yNC8w:10.10.70.0/24/default.
default['network']['extattrs'] = {} # extensible attributes associated with the object. eg. { 'Site' => { 'value' => 'Test Value' } }
