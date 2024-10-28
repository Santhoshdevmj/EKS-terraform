provider "kubernetes" {
  config_path = "~/.kube/config"  # Adjust the path to your kubeconfig
}

resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = <<EOT
- groups:
  - system:bootstrappers
  - system:nodes
  rolearn: arn:aws:iam::825765392239:role/my-demo-tf-cluster-eks-node-role
  username: system:node:{{EC2PrivateDNSName}}
EOT

    mapUsers = <<EOT
- groups:
  - system:masters
  userarn: arn:aws:iam::825765392239:user/devsanthosh
  username: devsanthosh
EOT
  }
}