include_recipe 'jenkins::java'

node.default['jenkins']['master']['version'] = '1.651.2'
node.default['jenkins']['master']['repository'] = 'http://pkg.jenkins-ci.org/debian-stable'
node.default['jenkins']['master']['repository_key'] = 'http://pkg.jenkins-ci.org/debian-stable/jenkins-ci.org.key'
node.default['jenkins']['master']['jvm_options'] = '-Dhudson.model.DirectoryBrowserSupport.CSP='
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

jobs = %w(job-dsl-seed.xml)

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

plugins = %w(git ansicolor postbuildscript job-dsl cucumber-reports htmlpublisher)

plugins.each do |plugin|
  jenkins_plugin plugin do
    notifies :restart, "service[jenkins]", :immediately
  end
end
