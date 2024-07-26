# IAM Role for EKS Cluster
resource "aws_iam_role" "toyeglobal_eks_cluster_role" {
  name = "toyeglobal-eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      },
    ]
  })
}

# Attach EKS Cluster Policy
resource "aws_iam_role_policy_attachment" "toyeglobal_eks_cluster_policy" {
  role       = aws_iam_role.toyeglobal_eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# IAM Role for EKS Nodes
resource "aws_iam_role" "toyeglobal_eks_node_role" {
  name = "toyeglobal-eks-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      },
    ]
  })
}

# Attach EKS Worker Node Policy
resource "aws_iam_role_policy_attachment" "toyeglobal_eks_worker_node_policy" {
  role       = aws_iam_role.toyeglobal_eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

# Attach EKS CNI Policy
resource "aws_iam_role_policy_attachment" "toyeglobal_eks_cni_policy" {
  role       = aws_iam_role.toyeglobal_eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

# Attach EC2 Container Registry Read-Only Policy
resource "aws_iam_role_policy_attachment" "toyeglobal_eks_ec2_policy" {
  role       = aws_iam_role.toyeglobal_eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}
