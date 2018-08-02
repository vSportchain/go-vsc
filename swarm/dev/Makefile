.PHONY: build cluster test

default: build

build:
	go build -o bin/swarm    github.com/xonechain/go-xone/cmd/swarm
	go build -o bin/gxone     github.com/xonechain/go-xone/cmd/gxone
	go build -o bin/xoneboot github.com/xonechain/go-xone/cmd/xoneboot

cluster: build
	scripts/boot-cluster.sh

test:
	go test -v github.com/xonechain/go-xone/swarm/...
