include_recipe 'jenkins::java'

node.default['jenkins']['master']['version'] = '1.651.1'
node.default['jenkins']['master']['repository'] = 'http://pkg.jenkins-ci.org/debian-stable'
node.default['jenkins']['master']['repository_key'] = 'http://pkg.jenkins-ci.org/debian-stable/jenkins-ci.org.key'
include_recipe 'jenkins::master'

docker_service 'default' do
  action [:create, :start]
end

group 'docker' do
  action :modify
  members ['jenkins']
  append true
  notifies :restart, "service[jenkins]", :immediately
end

xml_filename = File.join(Chef::Config[:file_cache_path], 'test-config.xml')

template xml_filename do
 source 'test-config.xml.erb'
end

jenkins_job 'docker-hello-world' do
 config xml_filename
 action :create
end
