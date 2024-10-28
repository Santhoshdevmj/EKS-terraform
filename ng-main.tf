# Node Group for EKS Cluster
resource "aws_eks_node_group" "demo_node_group" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${var.eks_name}-eks-nodegroup"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = aws_subnet.private_subnets[*].id  # Use private subnets

  scaling_config {
    desired_size = 3
    max_size     = 3
    min_size     = 3
  }

  ami_type       = "AL2_x86_64"  # Use Amazon EKS optimized AMI
  instance_types = ["t3.medium"]

  depends_on = [aws_eks_cluster.main, aws_iam_role_policy_attachment.eks_cluster_AmazonEKSClusterPolicy]
}


# IAM Role for Node Group
resource "aws_iam_role" "eks_node_role" {
  name = "${var.eks_name}-eks-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Effect = "Allow"
        Sid    = ""
      },
    ]
  })
}

# Attach policies to Node Group Role
resource "aws_iam_role_policy_attachment" "eks_worker_node_AmazonEKSWorkerNodePolicy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "eks_worker_node_AmazonEKS_CNI_Policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "eks_worker_node_AmazonEC2ContainerRegistryReadOnly" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

# Launch Template for custom AMI
resource "aws_launch_template" "node_group_template" {
  name_prefix   = "${var.eks_name}-eks-nodegroup-"
  image_id      = "ami-09b0a86a2c84101e1"  # Ubuntu 24 AMI
  instance_type = "t3.medium"

  # Ensure no key_name for SSH access since it's not needed
  lifecycle {
    create_before_destroy = true
  }
}