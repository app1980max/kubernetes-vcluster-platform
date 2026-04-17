
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

# Export kubeconfig
resource "null_resource" "kubeconfig" {
  depends_on = [helm_release.vcluster]

  provisioner "local-exec" {
    command = "vcluster connect ${var.name} --namespace ${var.namespace} --print > kubeconfig-${var.name}"
  }
}

output "kubeconfig_path" {
  value = "${path.module}/kubeconfig-${var.name}"
}
