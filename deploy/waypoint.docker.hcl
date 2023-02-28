
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

app "karn-engine" {
    labels = {
        "service" = "karn-engine",
        "env"     = "local"
    }

    url {
        // Disable the Waypoint URL service from generating a name
        // for this app
        auto_hostname = false
    }

    build {
        use "docker-pull" {
            image = "karn-engine"
            tag   = "linux-latest"
            disable_entrypoint = true
        }
    }

    deploy {
        use "docker" {
            name  = app.name
        }
    }

}
    
app "rabbitmq" {
    labels = {
        "service" = "rabbitmq",
        "env"     = "local"
    }

    url {
        // Disable the Waypoint URL service from generating a name
        // for this app
        auto_hostname = false
    }

    build {
        use "docker-pull" {
            image = "rabbitmq"
            tag   = "3-management-alpine"
            disable_entrypoint = true
        }
    }

    deploy {
        use "docker" {
            name  = app.name
        }
    }
}
