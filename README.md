# Zero To Tested Workshop

Code to support workshop

## Infrastructure

### Vagrant

* Simple Vagrantfile using Ubuntu 14.04 base with chef provisioning

### Chef

* Jenkins Cookbook
* Docker Cookbook
* Zero To Tested Cookbook
  - require java
  - add jenkins official apt repo (otherwise we get Jenkins 2 from default repos by default and Chef doesn't yet support it)
  - start docker
  - add jenkins user to docker group
  - use jenkins cookbook to install our job dsl seed job xml
  - install required jenkins plugins (git, ansicolor, postbuildscript, cucumber reports)
* `berks vendor cookbooks` - to bundle dependencies

### Job DSL

* Preferred to Job Builder as it's suuported by Jenkins core team and still relevant in Jenkins 2.0
* Seed job will trigger apply of jobs via Job DSL plugin
* Simple Groovy DSL for configuring Jobs
* Great plugin support

### Packer

* Bake an AMI that looks like our Vagrant VM
* Use base AMI (official Ubuntu cloud image - https://cloud-images.ubuntu.com/)

### Terraform

* Builds out infrastructure
* Saves using CloudFormation
* VPC
* Single instance - uses ami build using Packer
* Security Groups
* Could easily switch to Jenkins master/agent configuration with autoscaling agents
* `terraform apply` - takes us from empty ec2 account to fully functioning Jenkins with working jobs

### Cucumber

* Dependencies - see Gemfile
* Cucumber for BDD
* Capybara as driver agnostic dsl
* Site Prism for page objects
* RSpec for assertions
* RackTest for headless non JS driver (could use Mechanize for remote http)
* PhantomJS (via Poltergeist) for headless JS driver

#### ZeroApp

* Small Sinatra Demo App
* Runs with Puma Server

#### Features of tests

* Page Objects
* Wait Strategies
* Logging
* Screenshots and HTML source dropped on failure
* Start and stop application under test
