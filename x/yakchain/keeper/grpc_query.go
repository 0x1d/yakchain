package keeper

import (
	"github.com/0x1d/yakchain/x/yakchain/types"
)

var _ types.QueryServer = Keeper{}
