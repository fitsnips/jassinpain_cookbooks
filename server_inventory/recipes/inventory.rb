#
# Cookbook Name:: server_inventory
# Recipe:: inventory
#
# Copyright 2010, Joshua SS Miller <jassinpain@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "server_inventory::default"

# initiate array
my_hosts = {}

# get a timestamp for the report
timeNow=Time.now.to_s

# Get a list of all the nodes chef has
my_hosts = search(:node,"*:*") 
 

node[:server_inventory][:output_format].each do |format|
  template "inventory.#{format}" do
    path "#{node[:server_inventory][:output_dir]}/inventory.#{format}"
    source "server_inv.#{format}.erb"
    owner "root"
    group "root"
    mode 0644
    variables(
       :my_hosts  =>  my_hosts.sort,
       :time_now  => timeNow,
       :server_count => my_hosts.count
    )
  end
end

