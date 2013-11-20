#
# Cookbook Name:: dhcpd
# Recipe:: default
#
# Copyright 2011, Joshua SS Miller
# Copyright 2013, Continuuity, Inc.
#

# We only support Ubuntu
case node['platform']
when 'ubuntu'
  case node['platform_version'].to_i
  when 10
    svc = 'dhcp3-server'
    pkg = svc
    tpl = svc
    dir = 'dhcp3'
  when 12
    svc = 'isc-dhcp-server'
    pkg = svc
    tpl = svc
    dir = 'dhcp'
  else
    Chef::Application.fatal!("Unsupported platform/version")
  end
end

service svc

package pkg do
  if node[:dhcpd][:version]
    version node[:dhcpd][:version]
    action :install
  else
    action :install
  end
end

directory dir do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

template "/etc/default/#{tpl}" do
  source "dhcp3-server.erb"
  owner "root"
  group "root"
  mode 0644
  notifies(:restart, resources(:service => svc))
end

template "/etc/#{dir}/dhcpd.conf" do
  source "dhcpd.conf.erb"
  owner "root"
  group "root"
  mode 0644
  notifies(:restart, resources(:service => svc))
end
