
resource "kubernetes_namespace" "innovation" {
  metadata {
    name = "innovation"

    labels = {
      managed-by = "terraform"
      environment = "innovation"
    }
  }
}
