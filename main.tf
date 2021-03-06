provider "helm" {
  kubernetes {
    config_path = "./.kube/config"
  }
}

variable "password" {
  type = string
  default = "password"
  sensitive = true
}

variable "newpassword" {
  type = string
  default = "newpassword"
  sensitive = true
}

locals {
  triggers = sensitive({
    foo = "bar"
  })
}

resource "null_resource" "none" {
  triggers = local.triggers
}

resource "helm_release" "sets_example1" {
  name       = "redis-rank1"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "redis"
  version    = "6.2"

  set {
    name = "architecture"
    value = "standalone"
  }

  set {
    name = "redis.replicacount"
    value = "1"
  }
}

resource "helm_release" "sets_example2" {
  name       = "redis-rank2"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "redis"
  version    = "6.2"

  set {
    name = "architecture"
    value = "standalone"
  }

  set {
    name = "redis.replicacount"
    value = "1"
  }

  set {
    name = "auth.password"
    value = var.password
  }
}
