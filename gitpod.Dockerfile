image:
  file: .gitpod.Dockerfile

checkoutLocation: "starport"

workspaceLocation: "./starport/.gitpod"

tasks:
  - name: Open the Readme
    command: gp open readme.md

  - name: Setup

    init: |
      ##
      ## install Starport
      make -C /workspace/starport install

    command: |
      ##
      # configure env vars.      
      echo "
      export VUE_APP_CUSTOM_URL=$(gp url)
      export CHISEL_ADDR=$(gp url 7575)
      export RPC_ADDRESS=$(gp url 26657):443
      export API_ADDRESS=$(gp url 1317)
      " >> ~/.bashrc && source ~/.bashrc

      echo "
      export VUE_APP_API_COSMOS=${API_ADDRESS}
      export VUE_APP_API_TENDERMINT=${RPC_ADDRESS}
      export VUE_APP_WS_TENDERMINT=${RPC_ADDRESS/https/wss}/websocket
      " >> ~/.bashrc && source ~/.bashrc

      ##
      # cd into the .gitpod dir.
      cd .gitpod

      ##
      # print a welcome message.
      clear && printf '\e[3J'
      echo -e "
      This terminal has the \033[1mstarport\033[0m binary already installed and ready to go.

      "

ports:
  - port: 1317
  - port: 26657
  - port: 8080
  - port: 7575
    visibility: public
  - port: 4500