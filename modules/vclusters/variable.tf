variable "name" {}
variable "namespace" {}

variable "kubeconfig_path" {
  description = "Number of additional control planes for HA"
  type        = string
  default     = "~/.kube/config"
}
