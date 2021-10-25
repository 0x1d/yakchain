BIN = ~/go/bin/yakchaind
CHAIN = build serve
WAYPOINT = init build deploy release

default: info

it: starport cluster
so: ui dev


info:
	@echo "Starport: ${CHAIN}"
	@echo "Waypoint: ${WAYPOINT}"

$(CHAIN):
	starport chain $@

#$(WAYPOINT):
#	waypoint $@

# ---

dev:
	starport chain serve --reset-once --proto-all-modules

ui:
	cd vue && waypoint init && waypoint up

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

starport:
	curl https://get.starport.network/starport! | bash

not:
	k3d cluster delete yakchain