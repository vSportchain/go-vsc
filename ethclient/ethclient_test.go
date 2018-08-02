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

package ethclient

import "github.com/vsportchain/go-vsc"

// Verify that Client implements the vsportchain interfaces.
var (
	_ = vsportchain.ChainReader(&Client{})
	_ = vsportchain.TransactionReader(&Client{})
	_ = vsportchain.ChainStateReader(&Client{})
	_ = vsportchain.ChainSyncReader(&Client{})
	_ = vsportchain.ContractCaller(&Client{})
	_ = vsportchain.GasEstimator(&Client{})
	_ = vsportchain.GasPricer(&Client{})
	_ = vsportchain.LogFilterer(&Client{})
	_ = vsportchain.PendingStateReader(&Client{})
	// _ = vsportchain.PendingStateEventer(&Client{})
	_ = vsportchain.PendingContractCaller(&Client{})
)
