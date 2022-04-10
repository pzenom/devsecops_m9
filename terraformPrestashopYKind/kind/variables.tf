variable "k_cluster_name" {
    type = string
    description = "Nombre del cluster"
    default = "my-cluster"  
}

variable "k_cluster_config" {
    type = string
    description = "Path del cluster"
    default = "~/.kube/config"  
}

variable "k_cluster_ns" {
    type = string
    description = "Nombre del cluster"
    default = "my-cluster-ns"  
}
