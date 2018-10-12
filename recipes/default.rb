#
# Cookbook:: jenkins
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
remote_file '/tmp/jenkins.io.key' do
	source 'https://pkg.jenkins.io/debian/jenkins.io.key'
	notifies :run, 'execute[apt-key add /tmp/jenkins.io.key]', :immediately
end

execute 'apt-key add /tmp/jenkins.io.key' do
	action :nothing
end

# sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
file '/etc/apt/sources.list.d/jenkins.list' do
	content 'deb http://pkg.jenkins.io/debian-stable binary/'
	notifies :run, 'execute[apt update]', :immediately
end

# sudo apt-get update
execute 'apt update' do
	action :nothing
end

# sudo apt-get install jenkins
package 'jenkins'
