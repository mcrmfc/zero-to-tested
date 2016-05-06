#!/usr/bin/env bash
function green {
    tput setaf 2
    echo $1
    tput setaf 7
}

function yellow {
    tput setaf 3
    echo $1
    tput setaf 7
}

function red {
    tput setaf 4
    echo $1
    tput setaf 7
}

image_name=${1:-zero/test}
container_name=${2:-zerocuke}

if [ -z "$3" ]
then
    workdir_name=$(pwd)
else
    workdir_name="$(pwd)/$3"
fi

if [ -z "$4" ]
then
    dockerdir_name=$(pwd)
else
    dockerdir_name="$(pwd)/$4"
fi

green "Image name: $image_name"
green "Container name: $container_name"
green "Workdir name: $workdir_name"
green "Location of Dockerfile: $dockerdir_name"

running=`docker ps -q -f "name=$container_name"`
stopped=`docker ps -a -q -f "name=$container_name"`
image=`docker images | grep "$image_name"`

if [[ $running ]]; then
    green "container running - now stopping and deleting"
    docker stop $container_name
    docker rm $container_name
elif [[ $stopped ]]; then
    green "container stopped - now deleting"
    docker rm $container_name
elif [[ $image ]]; then
    green "containers stopped but image exists - not deleting as we want cached image if you want to please run 'docker rmi $image_name'"
    # docker rmi $image_name
else
    green "neither container or image exists"
fi

green 'Building docker image (should be mostly cached)...'
docker build -t $image_name $dockerdir_name

green 'Running docker image...'
docker run -d --name $container_name -v $workdir_name:/opt/ruby -e BUNDLE_GITHUB__COM=$DOCKER_TOKEN:x-oauth-basic $image_name

green 'Update bundler'
docker exec $container_name gem install --no-ri --no-rdoc bundler
