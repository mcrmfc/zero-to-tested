#!/bin/bash

# run report collation and stop docker container
#cd cucumber
#docker exec $CONTAINER_NAME bin/rake junit_merge THREAD_COUNT=$THREAD_COUNT BUNDLE_EXEC=bin/
#docker exec $CONTAINER_NAME bin/rake json_merge BUNDLE_EXEC=bin/

# stop docker container
docker/docker_stop.sh zero/test $CONTAINER_NAME
