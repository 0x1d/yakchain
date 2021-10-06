package keeper_test

import (
	"context"
	"testing"

	keepertest "github.com/0x1d/yakchain/testutil/keeper"
	"github.com/0x1d/yakchain/x/yakchain/keeper"
	"github.com/0x1d/yakchain/x/yakchain/types"
	sdk "github.com/cosmos/cosmos-sdk/types"
)

func setupMsgServer(t testing.TB) (types.MsgServer, context.Context) {
	k, ctx := keepertest.YakchainKeeper(t)
	return keeper.NewMsgServerImpl(*k), sdk.WrapSDKContext(ctx)
}
