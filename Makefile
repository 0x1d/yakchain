deps: waypoint starport
serve: serve-ui serve-chain

serve-ui:
	cd vue && waypoint up

serve-chain:
	starport chain serve

waypoint:
	waypoint install -platform=docker -accept-tos

starport:
	curl https://get.starport.network/starport! | bash
