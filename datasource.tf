
### Gather some data from vault
data "vault_generic_secret" "bootvm" {
  path = "secret/bootvm"
}
data "vault_generic_secret" "mgmt_cluster" {
    path = "secret/mgmt_cluster"
}

data "vault_generic_secret" "tkg_env" {
    path = "secret/tkg_env"
}

data "vault_generic_secret" "vsphere_env" {
    path = "secret/vsphere_env"
}


#### SSH Host
data "sshclient_host" "bootvm_keyscan" {
  hostname                 = local.bootvm_ip
  port                     = 22
  username                 = "root"
  insecure_ignore_host_key = true
}

data "sshclient_keyscan" "bootvm" {
  host_json = data.sshclient_host.bootvm_keyscan.json
}

data "sshclient_host" "bootvm_main" {
  extends_host_json = data.sshclient_host.bootvm_keyscan.json
  password          = local.bootvm_password
  host_publickey_authorized_key = data.sshclient_keyscan.bootvm.authorized_key
}

locals {
    mgmt_kubeconfig = base64decode(jsondecode(data.vault_generic_secret.mgmt_cluster.data_json).kubeconf)
    bootvm_ip = jsondecode(data.vault_generic_secret.bootvm.data_json).ip
    bootvm_password = jsondecode(data.vault_generic_secret.bootvm.data_json).password
    bootvm_rsa = jsondecode(data.vault_generic_secret.bootvm.data_json).rsa

    tkg_env_datacenter = jsondecode(data.vault_generic_secret.tkg_env.data_json).datacenter
    tkg_env_datastore = jsondecode(data.vault_generic_secret.tkg_env.data_json).datastore
    tkg_env_datastore_url = jsondecode(data.vault_generic_secret.tkg_env.data_json).datastore_url
    tkg_env_resource_pool = jsondecode(data.vault_generic_secret.tkg_env.data_json).resource_pool
    tkg_env_vm_folder = jsondecode(data.vault_generic_secret.tkg_env.data_json).vm_folder
    tkg_env_network = jsondecode(data.vault_generic_secret.tkg_env.data_json).network
    tkg_env_cluster = jsondecode(data.vault_generic_secret.tkg_env.data_json).cluster
    
    vpshere_env_server = jsondecode(data.vault_generic_secret.vsphere_env.data_json).server
    vpshere_env_user = jsondecode(data.vault_generic_secret.vsphere_env.data_json).user
    vpshere_env_password = jsondecode(data.vault_generic_secret.vsphere_env.data_json).password
}
