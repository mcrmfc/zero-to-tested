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

jobs = %w(hello-docker-config.xml hello-cucumber-config.xml)

jobs.each do |job|
  filename = File.join(Chef::Config[:file_cache_path], job)
  template filename do
    source "#{job}.erb"
  end

  jenkins_job job.chomp('.xml') do
    config filename
    action :create
  end
end

plugins = %w(git ansicolor postbuildscript)

plugins.each do |plugin|
  jenkins_plugin plugin do
    notifies :restart, "service[jenkins]", :immediately
  end
end
