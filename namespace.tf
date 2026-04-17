
resource "kubernetes_namespace" "innovation" {
  metadata {
    name = "kubeai-system"

    labels = {
      "app"        = "innovation"
      "managed-by" = "terraform"
    }
  }
}
