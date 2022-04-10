provider "kubernetes" {
    config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
        # config_context_cluster   = "minikube" 
        config_path = "~/.kube/config"    
  }
}

resource "helm_release" "local" {
    name = "buildchart"
    chart = "./buildchart"
}
 
resource "kubernetes_namespace" "minikube-namspace" {
    metadata {
        name = "terraform-ns-cluster"
    }
}

resource "kubernetes_pod" "mypod1" {
  metadata {
    name = "mypod"
  }
  spec {
    container {
      image = "nginx"
      name  = "webcon"
    }
  }
}