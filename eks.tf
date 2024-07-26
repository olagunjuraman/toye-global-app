# EKS Cluster
resource "aws_eks_cluster" "toyeglobal_cluster" {
  name     = "toyeglobal-cluster"
  role_arn = aws_iam_role.toyeglobal_eks_cluster_role.arn

  vpc_config {
    subnet_ids = [aws_subnet.toyeglobal_subnet1.id, aws_subnet.toyeglobal_subnet2.id]
  }
}


# EKS Node Group
resource "aws_eks_node_group" "toyeglobal_node_group" {
  cluster_name    = aws_eks_cluster.toyeglobal_cluster.name
  node_group_name = "toyeglobal-node-group"
  node_role_arn   = aws_iam_role.toyeglobal_eks_node_role.arn
  subnet_ids      = [aws_subnet.toyeglobal_subnet2.id, aws_subnet.toyeglobal_subnet3.id]

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.toyeglobal_eks_worker_node_policy,
    aws_iam_role_policy_attachment.toyeglobal_eks_cni_policy,
    aws_iam_role_policy_attachment.toyeglobal_eks_ec2_policy,
  ]
}
