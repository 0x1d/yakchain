BIN = ~/go/bin/yakchaind
CHAIN = build serve
#WAYPOINT = init build deploy release
WAYPOINT = waypoint init && waypoint up -app
TARGETS = ui node

UID=$(shell id -u)
GUID=$(shell id -g)

default: info

it: cluster
so: ui node


info:
	@echo "Starport: ${CHAIN}"
#	@echo "Waypoint: ${WAYPOINT}"

$(CHAIN):
	starport chain $@

$(TARGETS):
	$(WAYPOINT) $@

#$(WAYPOINT):
#	waypoint $@

# ---

starport:
	curl https://get.starport.network/starport! | bash
	
serve-clean:
	starport chain serve --reset-once --proto-all-modules

ownchain:
	sudo chown -R ${UID}:${GUID} ${HOME}/.yakchain
dskaffold:
	docker run -ti -w /app -v $HOME/sdh:/home/.yakchain -v $PWD:/app starport/cli:0.16.0 app github.com/0x1d/yakchain
drun:
	docker run -ti -v $HOME/sdh:/home/.yakchain -v $PWD:/apps -p 1317:1317 -p 26657:26657 starport/cli:0.16.0 serve -p planet

# ---
start:
	~/go/bin/yakchaind start --home /home/master/.yakchain
query-posts:
	~/go/bin/yakchaind query yakchain posts
# ---

relayer:
	starport relayer configure --advanced --source-rpc "http://0.0.0.0:26657" --source-faucet "http://0.0.0.0:4500" --source-port "blog" --source-version "blog-1" --target-rpc "http://0.0.0.0:26659" --target-faucet "http://0.0.0.0:4501" --target-port "yakchain" --target-version "yakchain-1"

cluster:
	k3d cluster create yakchain --agents 3
	kubectl config use-context k3d-yakchain
	kubectl cluster-info
	waypoint install --platform=kubernetes -accept-tos
	waypoint ui -authenticate

not:
	k3d cluster delete yakchain
	waypoint context clear

include yakchaind.mk