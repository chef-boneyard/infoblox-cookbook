Chef Guide for Infoblox Cookbook users
======================================

Infoblox cookbook is a LWRP cookbook developed to automate the workflows that can create NIOS records along with provisioning/deprovisioning VMs in vCenter server. The cookbook has recipes that can be used in a chef environment. This section describes how to use this cookbook.

If you are new to Chef please continue reading the below section, also see the official documentation of Chef at www.chef.io.

Chef Overview:
==============
"Chef is a systems and cloud infrastructure automation framework that makes it easy to deploy servers and applications to any physical, virtual, or cloud location, no matter the size of the infrastructure. Each organization is comprised of one (or more) workstations, a single server, and every node that will be configured and maintained by the chef-client. Cookbooks (and recipes) are used to tell the chef-client how each node in your organization should be configured. The chef-client (which is installed on every node) does the actual configuration."

Chef Server:
============
Chef Server is a centralized store for the information needed to manage infrastructure with Chef. It acts as a hub for configuration data. The Chef server stores cookbooks, the policies that are applied to nodes, and metadata that describes each registered node that is being managed by the chef-client. It is recommended that you set up Chef Server when you need to manage more than one machine at a time.

Chef Client:
============
Chef Client (also known as the Chef Omnibus Installer) contains the core components of Chef needed to manage a server or workstation. The installer comprises the entire collection of things necessary to run Chef. Chef Client bundles core application scripts along with the necessary Ruby scripting engine. In production environments, Chef Client is installed on every system intended to be managed by Chef.

Chef Development Kit (Chef DK):
===============================
The Chef DK, a superset of Chef Client  includes all the components of Chef Client, plus the Chef Development Kit additional best-of-breed tools developed by the Chef community, in one package.
 
Chef Client Modes:
==================
Chef Client can operate in one of the below modes:

§  Local mode:
==============
When chef-client is running in local mode, it simulates a full Chef Server instance in memory. Any data that would have been saved to a server is written to the local directory.

§  Client mode:
===============
when chef-client is running in client mode, it assumes you have a Chef Server running on some other system on your network. In production, this is how most people use Chef. In client mode, chef-client is an agent (or service/daemon) that runs locally on a machine managed by Chef.

§  Solo mode:
=============
This mode was used with older versions of chef. Solo mode provides a limited subset of Chef functionality intended to be able to run Chef locally.

Chef Workstation:
=================
This is the place where the chef-client will be executed. It has to be configured with the knife.rb and the pem files necessary to validate with the chef-server. Please see the chef documentation to configure the workstation.

Once configured, the chef client can be run as below

chef-client -r infoblox::reserve_static_ip
or as shown below for running it in local mode

chef-client -z -r infoblox::reserve_static_ip


Infoblox cookbook Details:
==========================
The Infoblox cookbook wraps the public APIs available in the "infoblox" gem. Specifically it does the VM provisioning and de-provisioning operations of vCenter and allows DHCP and DNS configuration to be provided from a centrally managed Infoblox appliance.

The basic motive behind writing the cookbook were as follows:
1. To create a Chef pathway that will allow the workflows to be executed.
2. VMs to be provisioned/de-provisioned in the vCenter server.
3. The vNIOS Infoblox appliance to have the necessary network objects created and configured.

Requirements:
=============
This cookbook is tested with Chef (client) 12. It may work with or without modification on earlier versions of Chef, but Chef 12 is recommended.
