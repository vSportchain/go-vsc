# This Makefile is meant to be used by people that do not usually work
# with Go source code. If you know what GOPATH is then you probably
# don't need to bother with make. 

.PHONY: gvsc android ios gvsc-cross swarm evm all test clean
.PHONY: gvsc-linux gvsc-linux-386 gvsc-linux-amd64 gvsc-linux-mips64 gvsc-linux-mips64le
.PHONY: gvsc-linux-arm gvsc-linux-arm-5 gvsc-linux-arm-6 gvsc-linux-arm-7 gvsc-linux-arm64
.PHONY: gvsc-darwin gvsc-darwin-386 gvsc-darwin-amd64
.PHONY: gvsc-windows gvsc-windows-386 gvsc-windows-amd64

GOBIN = $(shell pwd)/build/bin
GO ?= latest
 
gvsc:
	build/env.sh go run build/ci.go install ./cmd/gvsc
	@echo "Done building."
	@echo "Run \"$(GOBIN)/gvsc\" to launch gvsc."

swarm:
	build/env.sh go run build/ci.go install ./cmd/swarm
	@echo "Done building."
	@echo "Run \"$(GOBIN)/swarm\" to launch swarm."

all:
	build/env.sh go run build/ci.go install

android:
	build/env.sh go run build/ci.go aar --local
	@echo "Done building."
	@echo "Import \"$(GOBIN)/gvsc.aar\" to use the library."

ios:
	build/env.sh go run build/ci.go xcode --local
	@echo "Done building."
	@echo "Import \"$(GOBIN)/gvsc.framework\" to use the library."

test: all
	build/env.sh go run build/ci.go test

lint: ## Run linters.
	build/env.sh go run build/ci.go lint

clean:
	rm -fr build/_workspace/pkg/ $(GOBIN)/*

# The devtools target installs tools required for 'go generate'.
# You need to put $GOBIN (or $GOPATH/bin) in your PATH to use 'go generate'.

devtools:
	env GOBIN= go get -u golang.org/x/tools/cmd/stringer
	env GOBIN= go get -u github.com/kevinburke/go-bindata/go-bindata
	env GOBIN= go get -u github.com/fjl/gencodec
	env GOBIN= go get -u github.com/golang/protobuf/protoc-gen-go
	env GOBIN= go install ./cmd/abigen
	@type "npm" 2> /dev/null || echo 'Please install node.js and npm'
	@type "solc" 2> /dev/null || echo 'Please install solc'
	@type "protoc" 2> /dev/null || echo 'Please install protoc'

# Cross Compilation Targets (xgo)

gvsc-cross: gvsc-linux gvsc-darwin gvsc-windows gvsc-android gvsc-ios
	@echo "Full cross compilation done:"
	@ls -ld $(GOBIN)/gvsc-*

gvsc-linux: gvsc-linux-386 gvsc-linux-amd64 gvsc-linux-arm gvsc-linux-mips64 gvsc-linux-mips64le
	@echo "Linux cross compilation done:"
	@ls -ld $(GOBIN)/gvsc-linux-*

gvsc-linux-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/386 -v ./cmd/gvsc
	@echo "Linux 386 cross compilation done:"
	@ls -ld $(GOBIN)/gvsc-linux-* | grep 386

gvsc-linux-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/amd64 -v ./cmd/gvsc
	@echo "Linux amd64 cross compilation done:"
	@ls -ld $(GOBIN)/gvsc-linux-* | grep amd64

gvsc-linux-arm: gvsc-linux-arm-5 gvsc-linux-arm-6 gvsc-linux-arm-7 gvsc-linux-arm64
	@echo "Linux ARM cross compilation done:"
	@ls -ld $(GOBIN)/gvsc-linux-* | grep arm

gvsc-linux-arm-5:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm-5 -v ./cmd/gvsc
	@echo "Linux ARMv5 cross compilation done:"
	@ls -ld $(GOBIN)/gvsc-linux-* | grep arm-5

gvsc-linux-arm-6:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm-6 -v ./cmd/gvsc
	@echo "Linux ARMv6 cross compilation done:"
	@ls -ld $(GOBIN)/gvsc-linux-* | grep arm-6

gvsc-linux-arm-7:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm-7 -v ./cmd/gvsc
	@echo "Linux ARMv7 cross compilation done:"
	@ls -ld $(GOBIN)/gvsc-linux-* | grep arm-7

gvsc-linux-arm64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/arm64 -v ./cmd/gvsc
	@echo "Linux ARM64 cross compilation done:"
	@ls -ld $(GOBIN)/gvsc-linux-* | grep arm64

gvsc-linux-mips:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips --ldflags '-extldflags "-static"' -v ./cmd/gvsc
	@echo "Linux MIPS cross compilation done:"
	@ls -ld $(GOBIN)/gvsc-linux-* | grep mips

gvsc-linux-mipsle:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mipsle --ldflags '-extldflags "-static"' -v ./cmd/gvsc
	@echo "Linux MIPSle cross compilation done:"
	@ls -ld $(GOBIN)/gvsc-linux-* | grep mipsle

gvsc-linux-mips64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips64 --ldflags '-extldflags "-static"' -v ./cmd/gvsc
	@echo "Linux MIPS64 cross compilation done:"
	@ls -ld $(GOBIN)/gvsc-linux-* | grep mips64

gvsc-linux-mips64le:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/mips64le --ldflags '-extldflags "-static"' -v ./cmd/gvsc
	@echo "Linux MIPS64le cross compilation done:"
	@ls -ld $(GOBIN)/gvsc-linux-* | grep mips64le

gvsc-darwin: gvsc-darwin-386 gvsc-darwin-amd64
	@echo "Darwin cross compilation done:"
	@ls -ld $(GOBIN)/gvsc-darwin-*

gvsc-darwin-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=darwin/386 -v ./cmd/gvsc
	@echo "Darwin 386 cross compilation done:"
	@ls -ld $(GOBIN)/gvsc-darwin-* | grep 386

gvsc-darwin-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=darwin/amd64 -v ./cmd/gvsc
	@echo "Darwin amd64 cross compilation done:"
	@ls -ld $(GOBIN)/gvsc-darwin-* | grep amd64

gvsc-windows: gvsc-windows-386 gvsc-windows-amd64
	@echo "Windows cross compilation done:"
	@ls -ld $(GOBIN)/gvsc-windows-*

gvsc-windows-386:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=windows/386 -v ./cmd/gvsc
	@echo "Windows 386 cross compilation done:"
	@ls -ld $(GOBIN)/gvsc-windows-* | grep 386

gvsc-windows-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=windows/amd64 -v ./cmd/gvsc
	@echo "Windows amd64 cross compilation done:"
	@ls -ld $(GOBIN)/gvsc-windows-* | grep amd64

vscmaster-linux-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/amd64 -v ./cmd/vscmaster
	@echo "Linux amd64 cross compilation done:"
	@ls -ld $(GOBIN)/vscmaster-linux-* | grep amd64

bootnode-linux-amd64:
	build/env.sh go run build/ci.go xgo -- --go=$(GO) --targets=linux/amd64 -v ./cmd/bootnode
	@echo "Linux amd64 cross compilation done:"
	@ls -ld $(GOBIN)/bootnode-linux-* | grep amd64
