#!/bin/bash


# run image
docker-machine start default
eval $(docker-machine env --shell bash)
docker run -ti --rm -u $(id -u):$(id -g) -v /$(pwd):/cwd -w //cwd @IMAGE_NAME@:user bash -l
