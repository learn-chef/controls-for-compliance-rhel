#
# Cookbook Name:: webserver
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.
include_recipe 'iptables::default'

# Apply firewall rules.
iptables_rule 'firewall'

# Install the httpd package.
package 'httpd'

# Enable and start the httpd service.
service 'httpd' do
  action [:enable, :start]
end

# Create the web_admin user and group.
group 'web_admin'

user 'web_admin' do
  group 'web_admin'
  system true
  shell '/bin/bash'
end

# Create the pages directory under the document root directory.
directory '/var/www/html/pages' do
  group 'web_admin'
  user 'web_admin'
end

# Add files to the site.
%w(index.html pages/page1.html pages/page2.html).each do |web_file|
  file File.join('/var/www/html', web_file) do
    content "<html>This is #{web_file}.</html>"
    group 'web_admin'
    user 'web_admin'
  end
end
