#!/bin/bash

git_short_hash=`git rev-parse --short HEAD`
image_tag="ubuntu/vtorcs:$git_short_hash"

# check if the image has been build previously
if [ -z $(docker images -q $image_tag) ]; then
    # image has not been build, building it
    echo "[vtorcs - docker build] docker image $image_tag not found."
    docker build -t $image_tag .
fi

docker run --rm -p 6080:80 -p 3101:3101 -v /dev/shm:/dev/shm $image_tag