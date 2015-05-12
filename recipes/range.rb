infoblox_range node[:range][:name1] do
  start_addr node[:range][:start_addr]
  end_addr node[:range][:end_addr]
  exclude node[:range][:exclude]
  usage_type node[:range][:usage_type]
  mac node[:range][:mac]
  network node[:range][:network]
end

infoblox_range node[:range][:name2] do
  start_addr node[:range][:start_addr]
  end_addr node[:range][:end_addr]
  exclude node[:range][:exclude]
  usage_type node[:range][:usage_type2]
end
