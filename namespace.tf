
resource "kubernetes_namespace" "innovation" {
  metadata {
    name = "innovation"

    labels = {
      "app"        = ""
      "managed-by" = "terraform"
    }
  }
}
