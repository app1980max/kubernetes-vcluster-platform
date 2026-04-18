
resource "helm_release" "vcluster" {
  name             = var.name
  repository       = "https://charts.loft.sh"
  chart            = "vcluster"
  namespace        = var.namespace
  create_namespace = true

  wait    = true
  timeout = 600

  # Use external values.yaml for all configuration
  # values = [file("${path.module}/vcluster-values.yaml")]

  # --- sync to host ---
  set {
    name  = "sync.toHost.ingresses.enabled"
    value = "true"
  }

  set {
    name  = "sync.toHost.services.enabled"
    value = "true"
  }

}

data "kubernetes_secret" "vcluster_kubeconfig" {
  depends_on = [helm_release.vcluster]

  metadata {
    name      = "vc-${var.name}"
    namespace = var.namespace
  }
}

output "kubeconfig" {
  value     = base64decode(data.kubernetes_secret.vcluster_kubeconfig.data["config"])
  sensitive = true
}
