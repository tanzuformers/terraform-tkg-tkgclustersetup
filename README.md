<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.7.0 |
| <a name="requirement_sshclient"></a> [sshclient](#requirement\_sshclient) | 1.0.1 |
| <a name="requirement_sshcommand"></a> [sshcommand](#requirement\_sshcommand) | 0.2.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | >= 1.7.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | n/a |
| <a name="provider_sshclient"></a> [sshclient](#provider\_sshclient) | 1.0.1 |
| <a name="provider_template"></a> [template](#provider\_template) | n/a |
| <a name="provider_vault"></a> [vault](#provider\_vault) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.ingress_system_nginx](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubectl_manifest.metallb](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubernetes_config_map.metallb_config](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/config_map) | resource |
| [kubernetes_namespace.ingress_system](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_namespace.metallb](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace) | resource |
| [kubernetes_storage_class.default_storge_class](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/storage_class) | resource |
| [sshclient_run.metallb_secret_geneation](https://registry.terraform.io/providers/luma-planet/sshclient/1.0.1/docs/resources/run) | resource |
| [kubectl_file_documents.metallb](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/data-sources/file_documents) | data source |
| [sshclient_host.bootvm_keyscan](https://registry.terraform.io/providers/luma-planet/sshclient/1.0.1/docs/data-sources/host) | data source |
| [sshclient_host.bootvm_main](https://registry.terraform.io/providers/luma-planet/sshclient/1.0.1/docs/data-sources/host) | data source |
| [sshclient_keyscan.bootvm](https://registry.terraform.io/providers/luma-planet/sshclient/1.0.1/docs/data-sources/keyscan) | data source |
| [template_file.metallb_config](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [vault_generic_secret.bootvm](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/generic_secret) | data source |
| [vault_generic_secret.mgmt_cluster](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/generic_secret) | data source |
| [vault_generic_secret.tkg_env](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/generic_secret) | data source |
| [vault_generic_secret.vsphere_env](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/data-sources/generic_secret) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_loadbalancer_range"></a> [cluster\_loadbalancer\_range](#input\_cluster\_loadbalancer\_range) | IP Range assigned to cluster loadbalancer | `any` | n/a | yes |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Cluster Name | `any` | n/a | yes |
| <a name="input_files_path"></a> [files\_path](#input\_files\_path) | Path of the input/output values | `string` | `"."` | no |
| <a name="input_tkg_vault_ip"></a> [tkg\_vault\_ip](#input\_tkg\_vault\_ip) | Vault server ip | `any` | n/a | yes |
| <a name="input_tkg_vault_root_token"></a> [tkg\_vault\_root\_token](#input\_tkg\_vault\_root\_token) | Vault root token | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_result"></a> [result](#output\_result) | n/a |
<!-- END_TF_DOCS -->