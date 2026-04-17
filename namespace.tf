
resource "kubernetes_namespace" "kestra" {
metadata {
name = "kestra"
labels = {
"app.kubernetes.io/managed-by" = "terraform"
  }
 }
}
