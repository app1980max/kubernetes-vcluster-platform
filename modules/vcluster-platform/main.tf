
resource "helm_release" "vcluster_platform" {
  name             = "vcluster-platform"
  namespace        = "vcluster-platform"
  create_namespace = true

  repository = "https://charts.loft.sh"
  chart      = "vcluster-platform"

  atomic          = true
  cleanup_on_fail = true
  timeout         = 900
  skip_crds       = false

  values = [
    file("${path.module}/values.yaml")
  ]

  set {
    name  = "strategy.type"
    value = "RollingUpdate"
  }

  set {
    name  = "env.DISABLE_LOFT_ROUTER"
    value = "true"
  }

  set {
    name  = "accessKeys[0].name"
    value = "admin"
  }

  set_sensitive {
    name  = "accessKeys[0].key"
    value = var.vcluster_admin_key
  }

  set {
    name  = "accessKeys[0].user"
    value = "admin"
  }

  # Enable agents
  set {
    name  = "env.DISABLE_AGENT"
    value = "false"
  }
}

