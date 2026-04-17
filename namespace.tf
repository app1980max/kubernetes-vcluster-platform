
resource "kubernetes_namespace" "kubeai-system" {
  metadata {
    name = "kubeai-system"
  }
}
