
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
            image = "rabbitmq"
            tag   = "3-management-alpine"
            disable_entrypoint = true
        }
    }

    deploy {
        use "helm" {
            name  = app.name
            chart = "${path.app}/deploy/k8s/helm/rabbitmq"

            set {
                name  = "deployment.name"
                value = "public-api"
            }

            // We use a values file so we can set the entrypoint environment
            // variables into a rich YAML structure. This is easier than --set
            values = [
                file(templatefile("${path.app}/deploy/k8s/helm/inf.yaml")),
                file(templatefile("${path.app}/deploy/k8s/helm/app.yaml")),
                file(templatefile("%{ if var.name != "" }${var.name}%{ else }${var.name}%{ endif }"))
            ]
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
        use "helm" {
            name  = app.name
            chart = "${path.app}/deploy/k8s/helm/rabbitmq"

            set {
                name  = "deployment.name"
                value = "public-api"
            }

            // We use a values file so we can set the entrypoint environment
            // variables into a rich YAML structure. This is easier than --set
            values = [
                file(templatefile("${path.app}/deploy/k8s/helm/inf.yaml")),
                file(templatefile("${path.app}/deploy/k8s/helm/app.yaml")),
                file(templatefile("%{ if var.name != "" }${var.name}%{ else }${var.name}%{ endif }"))
            ]
        }
    }
}
