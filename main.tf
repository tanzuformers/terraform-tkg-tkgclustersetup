terraform {
  required_providers {
    sshcommand = {
      source  = "invidian/sshcommand"
      version = "0.2.2"
    }
    sshclient = {
      source  = "luma-planet/sshclient"
      version = "1.0.1"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}
provider "vault" {
  address = "http://${var.tkg_vault_ip}:8200"
  token = var.tkg_vault_root_token
}

provider "kubectl" {
  config_path    = "${var.files_path}/${var.cluster_name}-kubeconfig"
  config_context = "${var.cluster_name}-admin@${var.cluster_name}"
}

provider "kubernetes" {
  config_path    = "${var.files_path}/${var.cluster_name}-kubeconfig"
  config_context = "${var.cluster_name}-admin@${var.cluster_name}"
}
provider "helm" {
  kubernetes {
    config_path = "${var.files_path}/${var.cluster_name}-kubeconfig"
  }
}

# Prepare the cluster with metallb, vsphere storage-class and ingress nginx

## Install pvclass
resource "kubernetes_storage_class" "default_storge_class" {
    metadata {
        name = "standard"
        annotations = {
            "storageclass.kubernetes.io/is-default-class" = "true"
        }
    }
    storage_provisioner = "csi.vsphere.vmware.com"
    parameters = {
        datastoreurl = local.tkg_env_datastore_url
    }
}

## Install metallb
resource "kubernetes_namespace" "metallb" {
    depends_on = [
      kubernetes_storage_class.default_storge_class
    ]
  metadata {
    name = "metallb-system"
  }
}

resource "sshclient_run" "metallb_secret_geneation" {
    depends_on = [
        kubernetes_namespace.metallb
    ]
    host_json         = data.sshclient_host.bootvm_main.json
    command           = "kubectl --kubeconfig=/root/tkglab/kubeconfig-${var.cluster_name} create secret generic -n metallb-system memberlist --from-literal=secretkey=\"$(openssl rand -base64 128)\""
}

data "kubectl_file_documents" "metallb" {
    content = file("${path.module}/template/metallb.yaml")
}

resource "kubectl_manifest" "metallb" {
    depends_on = [
        sshclient_run.metallb_secret_geneation
    ]
    count     = length(data.kubectl_file_documents.metallb.documents)
    yaml_body = element(data.kubectl_file_documents.metallb.documents, count.index)
}

data "template_file" "metallb_config" {
    template = file("${path.module}/template/metallb-config.yaml")
    vars = {
        loadbalancer_cidr: var.cluster_loadbalancer_range
    }
}


resource "kubernetes_config_map" "metallb_config" {
    depends_on = [
        kubectl_manifest.metallb
    ]
    metadata {
        name = "config"
        namespace = "metallb-system"
    }

    data = {
        "config" = data.template_file.metallb_config.rendered
    }
}


## Ingress

resource "kubernetes_namespace" "ingress_system" {
    depends_on = [
      kubernetes_storage_class.default_storge_class
    ]
  metadata {
    name = "ingress-system"
  }
}

resource "helm_release" "ingress_system_nginx" {
    depends_on = [
      kubernetes_namespace.ingress_system
    ]
    name       = "ingress-nginx"

    #repository = "https://helm.nginx.com/stable"
    repository = "https://kubernetes.github.io/ingress-nginx"
    #chart      = "nginx-ingress"
    chart = "ingress-nginx"
    #version    = ""

    
    namespace = "ingress-system"

}
