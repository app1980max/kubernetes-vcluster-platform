
resource "kubernetes_namespace" "yevgeni" {
  metadata {
    name = "kubeai-system"

    labels = {
      "app"        = "yevgeni"
      "managed-by" = "terraform"
    }
  }
}
