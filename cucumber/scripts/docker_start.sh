#!/bin/bash -e

docker/docker_run.sh zero/test $CONTAINER_NAME cucumber docker

cd cucumber

# ensure we have reports dir
mkdir -p reports

# bundle - note we are caching gems on the host file system to speed up docker start
_user=$(id jenkins -u)
_group=$(id jenkins -g)
docker exec -u $_user:$_group $CONTAINER_NAME bundle install --binstubs --path vendor/bundle

# clean reports
docker exec $CONTAINER_NAME bundle exec rake clean

# run static analysis
docker exec $CONTAINER_NAME bin/rake rubocop

# run tests
docker exec $CONTAINER_NAME bin/cucumber -f pretty -f json -o reports/report.json -f junit -o reports
