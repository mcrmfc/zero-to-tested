#!/bin/bash

docker/docker_run.sh zero/test $CONTAINER_NAME cucumber docker

cd cucumber

# ensure we have reports dir
mkdir -p reports

# bundle - note we are caching gems on the host file system to speed up docker start
docker exec -u 106:113 $CONTAINER_NAME bundle install --binstubs --path vendor/bundle

# clean reports
docker exec $CONTAINER_NAME bundle exec rake clean

# run tests
docker exec $CONTAINER_NAME bin/cucumber
