#!/usr/bin/env bash

set -e

push_images () {

	if [ "$TRAVIS_PULL_REQUEST" == "false" ]; then
	
		if [[ "$2" == "master" ]]; then
			docker tag $IMAGE_NAME "$1:latest"
			docker push "$1:latest"
			docker tag $IMAGE_NAME "$1:$VERSION"
			docker push "$1:$VERSION"
		fi
		
		if [[ "$2" == "develop" ]]; then
			docker tag $IMAGE_NAME "$1:develop"
			docker push "$1:develop"
		fi
		
		if [[ $2 =~ ^[R|r][L|l]-[0-9]+\.[0-9]+\.[0-9]+-[R|r][C|c]$ ]]; then
			docker tag $IMAGE_NAME "$1:$VERSION-RC"
			docker push "$1:$VERSION-RC"				
		fi
	fi
}

BRANCH=$(if [ "$TRAVIS_PULL_REQUEST" == "false" ]; then echo $TRAVIS_BRANCH; else echo $TRAVIS_PULL_REQUEST_BRANCH; fi)
echo "TRAVIS_BRANCH=$TRAVIS_BRANCH, PR=$PR, BRANCH=$BRANCH"

docker login -u $DOCKER_USER_DH -p $DOCKER_PASS_DH
push_images "supremotribunalfederal/$IMAGE_NAME" $BRANCH 

docker login -u $DOCKER_USER -p $DOCKER_PASS registry.stf.jus.br
push_images "registry.stf.jus.br/stfdigital/$IMAGE_INTERNAL_REGISTRY_NAME" $BRANCH 
