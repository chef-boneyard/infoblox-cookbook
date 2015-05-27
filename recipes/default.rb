# Cookbook Name: Infoblox
# Recipe Name: default

%w(fog rbvmomi infoblox).each do |gem_pkg| 
  chef_gem gem_pkg do
  	compile_time true
    action :install
  end
end

require 'infoblox'
require 'fog'

