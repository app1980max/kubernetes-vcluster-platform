
variable "kubeconfig_path" {
  type        = string
  description = "Path to kubeconfig for the target cluster"
  default     = "~/.kube/config"
}

variable "vclusters" {
  description = "Mapping of vCluster logical names to internal identifiers"
  type        = map(string)
  default     = {}  # optional, can be empty
}
