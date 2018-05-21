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
│       ├── ca
│       │   ├── 072d3081571cac0258ae1b6bc2d70a83d9222d9385a8bbb5d28d3e369fd26316_sk
│       │   └── ca.study.com-cert.pem
│       ├── msp
│       │   ├── admincerts
│       │   │   └── Admin@study.com-cert.pem
│       │   ├── cacerts
│       │   │   └── ca.study.com-cert.pem
│       │   └── tlscacerts
│       │       └── tlsca.study.com-cert.pem
│       ├── orderers
│       │   └── orderer.study.com
│       │       ├── msp
│       │       │   ├── admincerts
│       │       │   │   └── Admin@study.com-cert.pem
│       │       │   ├── cacerts
│       │       │   │   └── ca.study.com-cert.pem
│       │       │   ├── keystore
│       │       │   │   └── ccba9bfc57843c11fb4f36df175af7a649975970d3d526d899146dda3ae351aa_sk
│       │       │   ├── signcerts
│       │       │   │   └── orderer.study.com-cert.pem
│       │       │   └── tlscacerts
│       │       │       └── tlsca.study.com-cert.pem
│       │       └── tls
│       │           ├── ca.crt
│       │           ├── server.crt
│       │           └── server.key
│       ├── tlsca
│       │   ├── c5df2190aea2a46b74d3a59346c4d78b91299be02bd478fe102467849d27f902_sk
│       │   └── tlsca.study.com-cert.pem
│       └── users
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
        │   │   │   ├── admincerts
        │   │   │   │   └── Admin@org1.study.com-cert.pem
        │   │   │   ├── cacerts
        │   │   │   │   └── ca.org1.study.com-cert.pem
        │   │   │   ├── keystore
        │   │   │   │   └── 9257b07e9dfb21f1f9ac3886a966f538cbc8a12083c8194503501e32fe58e35f_sk
        │   │   │   ├── signcerts
        │   │   │   │   └── peer0.org1.study.com-cert.pem
        │   │   │   └── tlscacerts
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
```
