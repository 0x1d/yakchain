project = "yakchain"

# Labels can be specified for organizational purposes.
# labels = { "foo" = "bar" }

app "node" {

  labels = {
    "service" = "yak-chain",
    "env"     = "dev"
  }

  build {
    use "docker" {
      disable_entrypoint = true
    }
    registry {
      use "docker" {
        image = "registry.gitlab.com/zwirbel/yakchain/node"
        tag   = "latest"
        local = false
      }
    }
  }

  deploy {
    use "kubernetes-apply" {
      path        = "${path.app}/manifests/yakchain-node"
      prune_label = "app=yakchain"
    }
  }

  release {
    use "kubernetes" {}
  }
}

app "ui" {

  labels = {
    "service" = "yak-ui",
    "env"     = "dev"
  }

  build {
    use "docker" {
        context = "vue"
        dockerfile = "vue/Dockerfile"
        disable_entrypoint = true
    }
    registry {
      use "docker" {
        image = "registry.gitlab.com/zwirbel/yakchain/ui"
        tag   = "latest"
        local = false
      }
    }
  }

  deploy {
    use "kubernetes-apply" {
      path        = "${path.app}/manifests/yakchain-ui"
      prune_label = "app=yakchain"
    }
  }

  release {
    use "kubernetes" {
      load_balancer = true
      port = 3000
    }
  }
}