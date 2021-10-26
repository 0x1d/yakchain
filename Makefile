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
	
dev:
	starport chain serve --reset-once --proto-all-modules


start:
	~/go/bin/yakchaind start --home /home/master/.yakchain

dskaffold:
	docker run -ti -w /app -v $HOME/sdh:/home/.yakchain -v $PWD:/app starport/cli:0.16.0 app github.com/0x1d/yakchain
drun:
	docker run -ti -v $HOME/sdh:/home/.yakchain -v $PWD:/apps -p 1317:1317 -p 26657:26657 starport/cli:0.16.0 serve -p planet
# ---

query:
	~/go/bin/yakchaind query yakchain posts

# ---

cluster:
	k3d cluster create yakchain --agents 3
	kubectl config use-context k3d-yakchain
	kubectl cluster-info
	waypoint install --platform=kubernetes -accept-tos
	waypoint ui -authenticate

not:
	k3d cluster delete yakchain
	waypoint context clear


ownit:
	sudo chown -R ${UID}:${GUID} ${HOME}/.yakchain
include yakchaind.mk