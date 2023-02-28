
project = "karn"

variable "app_name" {
  type    = string
  default = "karn"
}

variable "dns" {
  type    = string
  default = "karn"
}

variable "container_registry" {
  type    = string
  default = ""
}

variable "docker_username" {
  type    = string
  default = ""
}

variable "docker_password" {
  type    = string
  default = ""
}

variable "image_tag" {
  type    = string
  default = "linux-latest"
}

variable "image_pull_policy" {
  type    = string
  default = "Always"
}

/*app "traefik" {
    build {
        use "docker-pull" {
            image = "traefik"
            tag   = "v2.9"
            disable_entrypoint = true
        }
    }
    deploy {
        use "helm" {
            name = app.name
            chart      = "traefik"
            repository = "https://traefik.github.io/charts"
            set {
              name  = "image.repository"
              value = "traefik"
            }

            set {
              name  = "image.tag"
              value = "v2.9"
            }
        }
    }
}*/

app "karn-engine" {
    labels = {
        "service" = "karn-engine",
        "env"     = "local"
    }

    /*url {
        // Disable the Waypoint URL service from generating a name
        // for this app
        auto_hostname = false
    }*/

    build {
        use "docker-pull" {
            image = "cderue/karn-engine"
            tag   = "linux-latest"
            disable_entrypoint = true
        }
    }

    deploy {
        use "kubernetes" {
          #probe_path = "/"
          service_port = 8080
        }
    }

    release {
        use "kubernetes" {
          //port      = 8080
          //node_port = 30000
          load_balancer = true
          port          = 8080
        }
    }
}
    
app "nats" {
    labels = {
        "service" = "nats",
        "env"     = "local"
    }

    /*url {
        // Disable the Waypoint URL service from generating a name
        // for this app
        auto_hostname = false
    }*/

    build {
        use "docker-pull" {
            image = "nats"
            tag   = "latest"
            disable_entrypoint = true
        }
    }

    deploy {
        use "kubernetes" {
          #probe_path = "/"
          service_port = 4222
        }
    }

    release {
        use "kubernetes" {
          load_balancer = true
          port          = 4222
        }
    }
}