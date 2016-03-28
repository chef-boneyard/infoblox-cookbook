infoblox CHANGELOG
==================

## v2.1.0 (2016-03-28)
* Add attributes infoblox.data_bag_name and infoblox.data_bag_item so that user - flexibility in the databag being used.
* Infoblox does not know 'extattrs', set 'extensible_attributes' instead.
* Add actions :create_or_update and :update to infoblox_host_record. These search by hostname only. If the host's ipv4address changes, a new Infoblox::HostIpv4addr is added unless replace_ipv4addrs is true.

## v2.0.0 (2016-03-18)
 * #2: Raise exceptions on failure in infoblox_api.rb so that converge will be stopped. (@jcejohnson)

## v1.0.0
 * Initial release
