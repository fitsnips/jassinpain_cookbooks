#
# Cookbook Name:: dhcpd
# Recipe:: default
#
# Copyright 2011, Joshua SS Miller
#

service "dhcp3-server"

package "dhcp3-server" do 
  if node[:dhcpd][:version]
    version node[:dhcpd][:version]
    action :install
  else
    action :install
  end
end


template "/etc/default/dhcp3-server" do
  source "dhcp3-server.erb"
  owner "root"
  group "root"
  mode 0644
  notifies(:restart, resources(:service => "dhcp3-server"))
end

template "/etc/dhcp3/dhcpd.conf" do
  source "dhcpd.conf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies(:restart, resources(:service => "dhcp3-server"))
end
