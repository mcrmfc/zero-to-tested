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

green 'Stopping and removing running container'
docker stop $container_name
docker rm $container_name

