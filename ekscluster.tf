resource "aws_eks_cluster" "netflix_eks" {
  name     = "netflix-eks-cluster"
  role_arn  = aws_iam_role.eks_cluster_role.arn
  version   = "1.30"  # Specify the desired EKS version

  vpc_config {
    subnet_ids = [
      aws_subnet.netflix_private_subnet_1.id,
      aws_subnet.netflix_private_subnet_2.id
    ]
    security_group_ids = [
      aws_security_group.netflix_private_sg.id
    ]
  }

  tags = {
    Name = "netflix-eks-cluster"
  }
}

# EKS Node Group
resource "aws_eks_node_group" "netflix_eks_node_group" {
  cluster_name    = aws_eks_cluster.netflix_eks.name
  node_group_name = "netflix-node-group"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = [
    aws_subnet.netflix_private_subnet_1.id,
    aws_subnet.netflix_private_subnet_2.id
  ]
  scaling_config {
    desired_size = 2
    max_size     = 10
    min_size     = 2
  }

  tags = {
    Name = "netflix-eks-node-group"
  }
}
