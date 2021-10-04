variable "files_path" {
    description = "Path of the input/output values"
    default = "."
}
variable "tkg_vault_ip" {
    description = "Vault server ip"
}
variable "tkg_vault_root_token" {
    description = "Vault root token"
}
variable "cluster_name" {
  description = "Cluster Name"
}
variable "cluster_loadbalancer_range"{
    description = "IP Range assigned to cluster loadbalancer"
}
