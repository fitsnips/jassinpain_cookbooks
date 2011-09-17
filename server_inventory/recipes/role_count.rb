#
# Cookbook Name:: server_inventory
# Recipe:: role_count
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

require 'chef/role'


# initiate array
role_list = Hash.new

# get a timestamp for the report
timeNow=Time.now.to_s

# Get a list of all the nodes chef has
#role_lists = search(:role,"*:*")
role_list = Chef::Role.list()

role_counts = {}
role_list.each do |role_name, url| 
 role_counts[role_name] = search(:node,"role:#{role_name}").count
end 


node[:server_inventory][:output_format].each do |format|
  template "role_count.#{format}" do
    path "#{node[:server_inventory][:output_dir]}/role_count.#{format}"
    source "role_count.#{format}.erb"
    owner "root"
    group "root"
    mode 0644
    variables(
       :time_now  => timeNow,
       :role_counts => role_counts
    )
  end
end

