terraform {
  required_version = "~> 1.1"
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.18.0"
    }
  }
}

provider "kubernetes" {
  config_path    = "~/.kube/config"
}

/*
resource "kubernetes_namespace" "ns" {
  metadata {
    labels = {
      mylabel = "jkim"
    }

    name = "default"
  }
}
*/

resource "kubernetes_deployment" "deployment" {
  metadata {
    name      = "webapp"
#    namespace = kubernetes_namespace.ns.metadata[0].name
    namespace = "default"
    labels = {
      app = "webapp"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "webapp"
      }
    }

    template {
      metadata {
        labels = {
          app = "webapp"
        }
      }

      spec {
        container {
          image = "nginx:latest"
          name  = "jkimk8s"
        }
      }
    }
  }
}

resource "kubernetes_service" "service" {
  metadata {
    name      = "webapp"
#    namespace = kubernetes_namespace.ns.metadata[0].name
    namespace = "default"
  }
  spec {
    selector = {
      app = kubernetes_deployment.deployment.metadata[0].labels.app
    }

    port {
      port        = 80
      target_port = 80
      node_port   = 31001
    }

    type = "NodePort"
  }
}
