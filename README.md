# Fabric_network 구성방법

> ## Way to generate fabric_network

1.  Set GOPATH & cd $GOPATH/src
2.  Hyperledger Fabric Source 다운로드
    ```
    $ git clone https://github.com/hyperledger/fabric.git
    ```
3.  Generate Crypto binaries
    ```
    $ cd fabric project & make release
    ```
4.  Go to Fabric Binaries

    ```
    $ cd release/darwin-amd64/bin/
    ```

    * configtxgen
    * configtxlator
    * cryptogen
    * get-docker-images.sh
    * orderer
    * peer

    > mkdir tool 폴더 생성 후 위의 binaries 모음

5.  crypto-config.yaml 작성

    * Commit 한 crypto-config.yaml 파일 참조
    * OrdererOrgs 와 PeerOrgs (Org1) 로 구성

    ```
    $ mkdir crypto-config
    $ ./tool/cryptogen generate --config=./crypto-config.yaml
    ```

    > crypto-config 디렉토리 밑에 crypto materials 생성됨

6.  crypto-config 구성요소 설명

```
.
├── ordererOrganizations
│   └── study.com
│       ├── ca  ## Root CA 의 key pair set
│       │   ├── 072d3081571cac0258ae1b6bc2d70a83d9222d9385a8bbb5d28d3e369fd26316_sk
│       │   └── ca.study.com-cert.pem
│       ├── msp ## Org MSP 의 공통 활용 Certificates
│       │   ├── admincerts
│       │   │   └── Admin@study.com-cert.pem
│       │   ├── cacerts
│       │   │   └── ca.study.com-cert.pem
│       │   └── tlscacerts
│       │       └── tlsca.study.com-cert.pem
│       ├── orderers
│       │   └── orderer.study.com
│       │       ├── msp
│       │       │   ├── admincerts  ## 해당 Org의 Administrator's X.590 Certificate
│       │       │   │   └── Admin@study.com-cert.pem
│       │       │   ├── cacerts   ## Root CA 의 X.509 Certificates
│       │       │   │   └── ca.study.com-cert.pem
│       │       │   ├── keystore   ## This folder is defined for the local MSP of a each Node. It contains the node's signing key.
│       │       │   │   └── ccba9bfc57843c11fb4f36df175af7a649975970d3d526d899146dda3ae351aa_sk
│       │       │   ├── signcerts   ## Node 별 signing key 와 pair 인 X.509 Certificates. endorsement 의 verify 를 담당.
│       │       │   │   └── orderer.study.com-cert.pem
│       │       │   └── tlscacerts  ## Root CA 의 X.509 Certificates for TLS communication
│       │       │       └── tlsca.study.com-cert.pem
│       │       └── tls
│       │           ├── ca.crt
│       │           ├── server.crt
│       │           └── server.key
│       ├── tlsca   ## TLSCA 의 key pair set
│       │   ├── c5df2190aea2a46b74d3a59346c4d78b91299be02bd478fe102467849d27f902_sk
│       │   └── tlsca.study.com-cert.pem
│       └── users   ## Admin user 의 MSP 와 tls material 정의
│           └── Admin@study.com
│               ├── msp
│               │   ├── admincerts
│               │   │   └── Admin@study.com-cert.pem
│               │   ├── cacerts
│               │   │   └── ca.study.com-cert.pem
│               │   ├── keystore
│               │   │   └── a834d04d40b2986bb0e649a6bea8011bf22d7c4ea7683302dc1f7fd602436725_sk
│               │   ├── signcerts
│               │   │   └── Admin@study.com-cert.pem
│               │   └── tlscacerts
│               │       └── tlsca.study.com-cert.pem
│               └── tls
│                   ├── ca.crt
│                   ├── client.crt
│                   └── client.key
└── peerOrganizations
    └── org1.study.com
        ├── ca
        │   ├── 67f94cc3a98490c721c8ae13912de007225a6919b8c6669b3bf044286c5a71c0_sk
        │   └── ca.org1.study.com-cert.pem
        ├── msp
        │   ├── admincerts
        │   │   └── Admin@org1.study.com-cert.pem
        │   ├── cacerts
        │   │   └── ca.org1.study.com-cert.pem
        │   └── tlscacerts
        │       └── tlsca.org1.study.com-cert.pem
        ├── peers
        │   ├── peer0.org1.study.com
        │   │   ├── msp
        │   │   │   ├── admincerts   ## 해당 Org의 Administrator's X.590 Certificate
        │   │   │   │   └── Admin@org1.study.com-cert.pem
        │   │   │   ├── cacerts   ## Root CA 의 X.509 Certificates
        │   │   │   │   └── ca.org1.study.com-cert.pem
        │   │   │   ├── keystore   ## This folder is defined for the local MSP of a each Node. It contains the node's signing key.
        │   │   │   │   └── 9257b07e9dfb21f1f9ac3886a966f538cbc8a12083c8194503501e32fe58e35f_sk
        │   │   │   ├── signcerts   ## Node 별 signing key 와 pair 인 X.509 Certificates. endorsement 의 verify 를 담당.
        │   │   │   │   └── peer0.org1.study.com-cert.pem
        │   │   │   └── tlscacerts   ## Root CA 의 X.509 Certificates for TLS communication
        │   │   │       └── tlsca.org1.study.com-cert.pem
        │   │   └── tls
        │   │       ├── ca.crt
        │   │       ├── server.crt
        │   │       └── server.key
        │   ├── peer1.org1.study.com
        │   │   ├── msp
        │   │   │   ├── admincerts
        │   │   │   │   └── Admin@org1.study.com-cert.pem
        │   │   │   ├── cacerts
        │   │   │   │   └── ca.org1.study.com-cert.pem
        │   │   │   ├── keystore
        │   │   │   │   └── 0c526d0876ca3fa642caf6a34c726be0bd4ae94543db9026119e6dd153618a83_sk
        │   │   │   ├── signcerts
        │   │   │   │   └── peer1.org1.study.com-cert.pem
        │   │   │   └── tlscacerts
        │   │   │       └── tlsca.org1.study.com-cert.pem
        │   │   └── tls
        │   │       ├── ca.crt
        │   │       ├── server.crt
        │   │       └── server.key
        │   ├── peer2.org1.study.com
        │   │   ├── msp
        │   │   │   ├── admincerts
        │   │   │   │   └── Admin@org1.study.com-cert.pem
        │   │   │   ├── cacerts
        │   │   │   │   └── ca.org1.study.com-cert.pem
        │   │   │   ├── keystore
        │   │   │   │   └── 42f062618c92306b3cdb2f1dbceb643c9445c51a7a6ce4bf894e6779e5e7d3fb_sk
        │   │   │   ├── signcerts
        │   │   │   │   └── peer2.org1.study.com-cert.pem
        │   │   │   └── tlscacerts
        │   │   │       └── tlsca.org1.study.com-cert.pem
        │   │   └── tls
        │   │       ├── ca.crt
        │   │       ├── server.crt
        │   │       └── server.key
        │   └── peer3.org1.study.com
        │       ├── msp
        │       │   ├── admincerts
        │       │   │   └── Admin@org1.study.com-cert.pem
        │       │   ├── cacerts
        │       │   │   └── ca.org1.study.com-cert.pem
        │       │   ├── keystore
        │       │   │   └── 54432a9ac2522f1ac5474bc3facc3990d4156c409d0d0adfb6c1be5c12ee0000_sk
        │       │   ├── signcerts
        │       │   │   └── peer3.org1.study.com-cert.pem
        │       │   └── tlscacerts
        │       │       └── tlsca.org1.study.com-cert.pem
        │       └── tls
        │           ├── ca.crt
        │           ├── server.crt
        │           └── server.key
        ├── tlsca
        │   ├── e4c65c6d3aee55d266691a6b7aea009f461f33a41508bf395d0e443b1b915b3e_sk
        │   └── tlsca.org1.study.com-cert.pem
        └── users
            ├── Admin@org1.study.com
            │   ├── msp
            │   │   ├── admincerts
            │   │   │   └── Admin@org1.study.com-cert.pem
            │   │   ├── cacerts
            │   │   │   └── ca.org1.study.com-cert.pem
            │   │   ├── keystore
            │   │   │   └── edb2f7b06223a6f9bb00601fb0542e1612769edcf8431af09f48b4ce5ce22f5b_sk
            │   │   ├── signcerts
            │   │   │   └── Admin@org1.study.com-cert.pem
            │   │   └── tlscacerts
            │   │       └── tlsca.org1.study.com-cert.pem
            │   └── tls
            │       ├── ca.crt
            │       ├── client.crt
            │       └── client.key
            └── User1@org1.study.com
                ├── msp
                │   ├── admincerts
                │   │   └── User1@org1.study.com-cert.pem
                │   ├── cacerts
                │   │   └── ca.org1.study.com-cert.pem
                │   ├── keystore
                │   │   └── 1b90ac92ce1dc895382643624a3f4f50bedc3868c388298c7ccd586c8f0d1bd2_sk
                │   ├── signcerts
                │   │   └── User1@org1.study.com-cert.pem
                │   └── tlscacerts
                │       └── tlsca.org1.study.com-cert.pem
                └── tls
                    ├── ca.crt
                    ├── client.crt
                    └── client.key
    └── org2.study.com
    ...
```

7.  configtx.yaml 작성

    * Commit 한 configtx.yaml 파일 참조
    * 두개의 profiles 로 구성
    * OrdererGenesisProfile (genesis.block 생성을 위한)
    * ChannelProfile (channel.tx, ${org}MSPanchors.tx)

    > profile : describe the organizational structure of your network
    > Organizations : details regarding individual organizations
    > Orderer : details regarding the Orderer parameters

    ```
    ## configtx 아웃풋 materials 모음
    $ mkdir channel-artifacts

    ## genesis.block 생성
    $ ./tool/configtxgen -profile OrdererGenesisProfile -outputBlock ./channel-artifacts/genesis.block

    ## channel.ts 생성
    $ ./tool/configtxgen -profile ChannelProfile -outputCreateChannelTx ./channel-artifacts/channel.tx -channelID $CHANNEL_NAME

    ## org 별 anchor peer channel tx 생성 ( multi org 활용시 필요 )
    $ ./tool/configtxgen -profile ChannelProfile -outputAnchorPeersUpdate ./channel-artifacts/Org1MSPanchors.tx -channelID $CHANNEL_NAME -asOrg Org1MSP
    ```

    > crypto-config 디렉토리 밑에 crypto materials 생성됨

```
.
├── Org1MSPanchors.tx   ## org1 의 anchor peer artifacts file
├── Org2MSPanchors.tx   ## org2 의 anchor peer artifacts file
├── channel.tx     ## channel 생성을 위한 artifact file
└── genesis.block  ## orderer running을 위한 genesis.block
```

1.
