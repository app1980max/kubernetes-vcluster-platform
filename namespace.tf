
resource "kubernetes_namespace" "ingress-nginx" {
metadata {
name = "ingress-nginx"
labels = {
"app.kubernetes.io/managed-by" = "terraform"
  }
 }
}
