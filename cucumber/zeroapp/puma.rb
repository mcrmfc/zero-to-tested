## Load 'path' as a rackup file.
###
rackup "#{File.dirname(__FILE__)}/config.ru"
#
##
### Set the environment in which the rack's app will run. The value must be a string.
###
### The default is 'development'.
###
### environment 'production'
##
### Daemonize the server into the background. Highly suggest that
### this be combined with 'pidfile' and 'stdout_redirect'.
###
### The default is 'false'.
daemonize true
##
### Store the pid of the server in the file at 'path'.
###
pidfile 'puma.pid'
##
### Redirect STDOUT and STDERR to files specified. The 3rd parameter
### ('append') specifies whether the output is appended, the default is
### 'false'.
###
stdout_redirect 'zero_stdout', 'zero_stderr'
##
### Disable request logging.
###
### The default is 'false'.
###
### quiet
bind 'tcp://0.0.0.0:4567'
