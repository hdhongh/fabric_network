#!/bin/bash +x
#
# Copyright IBM Corp. All Rights Reserved.
#
# SPDX-License-Identifier: Apache-2.0
#

#set -e

CHANNEL_NAME=$1
: ${CHANNEL_NAME:="studychannel"}
echo $CHANNEL_NAME

export FABRIC_CFG_PATH=$PWD
echo

OS_ARCH=$(echo "$(uname -s|tr '[:upper:]' '[:lower:]'|sed 's/mingw64_nt.*/windows/')-$(uname -m | sed 's/x86_64/amd64/g')" | awk '{print tolower($0)}')

## Generates Org certs using cryptogen tool
function generateCerts (){
        CRYPTOGEN=tool/$OS_ARCH/cryptogen

        if [ -f "$CRYPTOGEN" ]; then
        echo "Using cryptogen -> $CRYPTOGEN"

        rm -r crypto-config
        echo
        echo "##########################################################"
        echo "##### Generate certificates using cryptogen tool #########"
        echo "##########################################################"
        $CRYPTOGEN generate --config=./crypto-config.yaml
        echo

        else
            echo "Cannot find the gen tool!"
        fi
}

## Generate orderer genesis block , channel configuration transaction and anchor peer update transactions
function generateChannelArtifacts() {
        CONFIGTXGEN=tool/$OS_ARCH/configtxgen
        if [ -f "$CONFIGTXGEN" ]; then

        mkdir channel-artifacts
        echo "Using configtxgen -> $CONFIGTXGEN"
        echo "##########################################################"
        echo "#########  Generating Orderer Genesis block ##############"
        echo "##########################################################"
        # Note: For some unknown reason (at least for now) the block file can't be
        # named orderer.genesis.block or the orderer will fail to launch!
        $CONFIGTXGEN -profile OrdererGenesisProfile -outputBlock ./channel-artifacts/genesis.block

        echo
        echo "#################################################################"
        echo "### Generating channel configuration transaction 'channel.tx' ###"
        echo "#################################################################"
        $CONFIGTXGEN -profile ChannelProfile -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID $CHANNEL_NAME

        echo
        echo "#################################################################"
        echo "## org 별 anchor peer channel tx 생성 ( multi org 활용시 필요 )"
        echo "#################################################################"
        
        idx=1
        for org in $(ls -d crypto-config/peerOrganizations/*)
        do            
            $CONFIGTXGEN -profile ChannelProfile -outputAnchorPeersUpdate ./channel-artifacts/Org"$idx"MSPanchors.tx -channelID $CHANNEL_NAME -asOrg Org"$idx"MSP
            idx=$(expr $idx + 1)
        done

        

        else
            echo "Building configtxgen"
        fi
}

## copy tlsCerts(peer, orderer), adminCerts, channel.tx, Org1MSPanchors.tx
function copyForClientTool(){
        rm -r copy

        for org in $(ls -d crypto-config/peerOrganizations/*)
        do
            dname=$(echo $org | cut -d'/' -f3);
            mkdir -p copy/tlsCerts/$dname;
            cp $org/msp/tlscacerts/*.pem copy/tlsCerts/$dname
        done

        for org in $(ls -d crypto-config/ordererOrganizations/*)
        do  
            mkdir -p copy/tlsCerts/orderer;
            cp $org/msp/tlscacerts/*.pem copy/tlsCerts/orderer
        done

        for org in $(ls -d crypto-config/peerOrganizations/*)
        do
            dname=$(echo $org | cut -d'/' -f3);
            mkdir -p copy/adminCerts/$dname;
            cp -r $org/users/Admin*/msp/keystore copy/adminCerts/$dname/
            cp -r $org/users/Admin*/msp/signcerts copy/adminCerts/$dname/
        done

        for org in $(ls -d crypto-config/peerOrganizations/*)
        do
            dname=$(echo $org | cut -d'/' -f3);
            mkdir -p copy/userCerts/$dname;
            cp -r $org/users/User*/msp/keystore copy/userCerts/$dname/
            cp -r $org/users/User*/msp/signcerts copy/userCerts/$dname/
        done

        cp channel-artifacts/channel.tx copy/
}

function setPKToEnv(){
        rm -f ./.env

        idx=1
        touch .env
        for org in $(ls -d ./crypto-config/peerOrganizations/*)
        do              
            ##orgDomain=$(echo $org | cut -d'/' -f4)
            
            ##echo domain=$(echo $orgDomain | cut -d'.' -f2-) >> .env
            ##echo orgNm_org$idx=$(echo $orgDomain | cut -d'.' -f-1) >> .env
            ##echo tlsCert_org$idx=$(basename $(echo $org/tlsca/*.pem)) >> .env
            echo tlsKey_org$idx=$(basename $(echo $org/tlsca/*_sk)) >> .env
            ##echo caCert_org$idx=$(basename $(echo $org/ca/*.pem)) >> .env
            echo caKey_org$idx=$(basename $(echo $org/ca/*_sk)) >> .env
            
            idx=$(expr $idx + 1)
        done
}

generateCerts
generateChannelArtifacts
copyForClientTool
setPKToEnv
