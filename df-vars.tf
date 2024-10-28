provider "kubernetes" {
  config_path = "~/.kube/config"  # Adjust the path to your kubeconfig
}

resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }