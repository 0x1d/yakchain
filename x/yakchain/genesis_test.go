package yakchain_test

import (
	"testing"

	keepertest "github.com/0x1d/yakchain/testutil/keeper"
	"github.com/0x1d/yakchain/x/yakchain"
	"github.com/0x1d/yakchain/x/yakchain/types"
	"github.com/stretchr/testify/require"
)

func TestGenesis(t *testing.T) {
	genesisState := types.GenesisState{
		// this line is used by starport scaffolding # genesis/test/state
	}

	k, ctx := keepertest.YakchainKeeper(t)
	yakchain.InitGenesis(ctx, *k, genesisState)
	got := yakchain.ExportGenesis(ctx, *k)
	require.NotNil(t, got)

	// this line is used by starport scaffolding # genesis/test/assert
}
