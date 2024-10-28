output "eks_cluster_id" {
  description = "The ID of the EKS Cluster"
  value       = aws_eks_cluster.main.id
}

output "eks_cluster_endpoint" {
  description = "The endpoint of the EKS Cluster"
  value       = aws_eks_cluster.main.endpoint
}

output "eks_cluster_certificate_authority_data" {
  description = "The certificate authority data for the EKS Cluster"
  value       = aws_eks_cluster.main.certificate_authority[0].data
}