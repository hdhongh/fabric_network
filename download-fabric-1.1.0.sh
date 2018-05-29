#!/bin/bash -eu

##################################################
# This script pulls docker images from hyperledger
# docker hub repository and Tag it as
# hyperledger/fabric-<image> <fabric tag>
##################################################

#Set ARCH variable i.e ppc64le,s390x,x86_64,i386
ARCH=`uname -m`
DOCKER_NS=hyperledger
VERSION=${ARCH}-1.1.0
VERSION_PREIVIEW=${ARCH}-1.1.0-preview
BASE_DOCKER_TAG=${ARCH}-0.4.7

#Set of Hyperledger Fabric images
FABRIC_IMAGES=(fabric-peer fabric-orderer fabric-tools)

for image in ${FABRIC_IMAGES[@]}; do
    echo "Pulling ${DOCKER_NS}/$image:${VERSION}"
    docker pull ${DOCKER_NS}/$image:${VERSION}
    docker tag ${DOCKER_NS}/$image:${VERSION} ${DOCKER_NS}/$image:latest
done

#Set of couch kafka zk images
DOCKER_IMAGES=(fabric-couchdb fabric-kafka fabric-zookeeper)

for image in ${DOCKER_IMAGES[@]}; do
    echo "Pulling ${DOCKER_NS}/$image:${BASE_DOCKER_TAG}"
    docker pull ${DOCKER_NS}/$image:${BASE_DOCKER_TAG}
    docker tag ${DOCKER_NS}/$image:${BASE_DOCKER_TAG} ${DOCKER_NS}/$image:latest
done

#Set of Hyperledger Fabric CA image
echo "Pulling ${DOCKER_NS}/fabric-ca:${VERSION_PREIVIEW}"
docker pull ${DOCKER_NS}/fabric-ca:${VERSION_PREIVIEW}
docker tag ${DOCKER_NS}/fabric-ca:${VERSION_PREIVIEW} ${DOCKER_NS}/fabric-ca:latest