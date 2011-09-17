default[:dhcpd][:version] = FALSE

default[:dhcpd][:interfaces] = [ 'eth0' ]
default[:dhcpd][:next_server] = "10.0.198.11"
default[:dhcpd][:routers] = "10.0.198.1"
default[:dhcpd][:netmask] = "255.255.254.0"
default[:dhcpd][:subnet] = '10.0.198.0'
default[:dhcpd][:range] = [ '10.0.199.201', '10.0.199.250' ]
default[:dhcpd][:default_leaser_time] = "600"
default[:dhcpd][:max_lease_time] = "7200"
default[:dhcpd][:filename] = "/pxelinux.0"
default[:dhcpd][:nameservers] = [ '10.0.198.11' ]
default[:dhcpd][:domain] = [ 'internal.mydomain.net' ]

