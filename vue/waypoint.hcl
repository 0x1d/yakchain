project = "yakchain"

app "ui" {

  labels = {
    "service" = "yak-ui",
    "env"     = "dev"
  }

  build {
    use "docker" {}
    registry {
      use "docker" {
        image = "registry.gitlab.com/zwirbel/yakchain/ui"
        tag   = "latest"
        local = false
      }
    }
  }

  deploy {
    use "kubernetes" {
      #probe_path = "/"
    }
  }

  release {
    use "kubernetes" {}
  }
}