
###  ---  vCluster-Platform Template  ---  ###

module "nginx" {
  source = "./modules/nginx"
  depends_on = [kubernetes_namespace.kestra]
}

module "argo-events" {
  source = "./modules/argo-events"
  depends_on = [module.nginx]
}

module "minio" {
  source = "./modules/minio"
  depends_on = [module.argo-events]
}

module "vcluster-platform" {
  source = "./modules/vcluster-platform"
  depends_on = [module.minio]
}

module "vclusters" {
  source = "./modules/vclusters"
  depends_on = [module.vcluster-platform]

  for_each = var.vclusters
  name      = "vcluster-${each.key}"
  namespace = "vcluster-${each.key}"
}



