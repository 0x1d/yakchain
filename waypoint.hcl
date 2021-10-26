project = "yakchain"

# Labels can be specified for organizational purposes.
# labels = { "foo" = "bar" }

app "node" {

  labels = {
    "service" = "yak-chain",
    "env"     = "dev"
  }

  build {
    use "docker" {}
    registry {
      use "docker" {
        image = "registry.gitlab.com/zwirbel/yakchain/node"
        tag   = "latest"
        local = true
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




#app "consul" {
#    build {}
#    deploy {
#        use "helm" {
#            repository = "https://helm.releases.hashicorp.com"
#            chart = "consul"
#            name = "consule"
#            #set {
#            #    name  = "deployment.image"
#            #    value = artifact.name
#            #}
#        }
#    }
#}
app "ui" {

  labels = {
    "service" = "yak-ui",
    "env"     = "dev"
  }

  build {
    use "docker" {
        context = "vue"
        dockerfile = "vue/Dockerfile"
    }
    registry {
      use "docker" {
        image = "registry.gitlab.com/zwirbel/yakchain/ui"
        tag   = "latest"
        local = true
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