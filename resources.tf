
data "external" "subnet" {
  program = ["/bin/bash", "-c", "docker network inspect -f '{{json .IPAM.Config}}' kind | jq .[0]"]
  depends_on = [
    kind_cluster.default
  ]
}

provider "helm" {
  kubernetes {
    config_path = pathexpand(var.kind_cluster_config_path)
  }
}

module "metallb" {
  source = "./modules/metallb"
  depends_on = [kind_cluster.default]
  kind_cluster_config_path = var.kind_cluster_config_path
}

module "nginx" {
  source = "./modules/nginx"
  depends_on = [module.metallb]
}

module "argo" {
  source = "./modules/argo"
  depends_on = [module.nginx]
}

module "argo-events" {
  source = "./modules/argo-events"
  depends_on = [module.argo]
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



