// Copyright 2016 The go-vsc Authors
// This file is part of the go-vsc library.
//
// The go-vsc library is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// The go-vsc library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public License
// along with the go-vsc library. If not, see <http://www.gnu.org/licenses/>.

// Contains all the wrappers from the params package.

package gvsc

import (
	"encoding/json"

	"github.com/vsportchain/go-vsc/core"
	"github.com/vsportchain/go-vsc/p2p/discv5"
	"github.com/vsportchain/go-vsc/params"
)

// MainnetGenesis returns the JSON spec to use for the main VSportChain network. It
// is actually empty since that defaults to the hard coded binary genesis block.
func MainnetGenesis() string {
	return ""
}

// TestnetGenesis returns the JSON spec to use for the VSportChain test network.
func TestnetGenesis() string {
	enc, err := json.Marshal(core.DefaultTestnetGenesisBlock())
	if err != nil {
		panic(err)
	}
	return string(enc)
}

// RinkebyGenesis returns the JSON spec to use for the Rinkeby test network
func RinkebyGenesis() string {
	enc, err := json.Marshal(core.DefaultRinkebyGenesisBlock())
	if err != nil {
		panic(err)
	}
	return string(enc)
}

// FoundationBootnodes returns the enode URLs of the P2P bootstrap nodes operated
// by the foundation running the V5 discovery protocol.
func FoundationBootnodes() *Enodes {
	nodes := &Enodes{nodes: make([]*discv5.Node, len(params.DiscoveryV5Bootnodes))}
	for i, url := range params.DiscoveryV5Bootnodes {
		nodes.nodes[i] = discv5.MustParseNode(url)
	}
	return nodes
}