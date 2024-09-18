# Security Group for Public Instances
resource "aws_security_group" "netflix_public_sg" {
  vpc_id = aws_vpc.netflix_vpc.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "netflix-public-sg"
  }
}

# Security Group for EKS Control Plane
resource "aws_security_group" "eks_control_plane_sg" {
  vpc_id = aws_vpc.netflix_vpc.id
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "eks-control-plane-sg"
  }
}

# Security Group for Private Subnets
resource "aws_security_group" "netflix_private_sg" {
  name        = "netflix-private-sg"
  description = "Private security group for Netflix EKS cluster"
  vpc_id      = aws_vpc.netflix_vpc.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]  # Adjust to your CIDR
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "netflix-private-sg"
  }
}


# Security Group for Worker Nodes
resource "aws_security_group" "eks_worker_sg" {
  vpc_id = aws_vpc.netflix_vpc.id
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    security_groups = [aws_security_group.eks_control_plane_sg.id]
  }
  ingress {
    from_port   = 1025
    to_port     = 65535
    protocol    = "tcp"
    security_groups = [aws_security_group.eks_control_plane_sg.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "eks-worker-sg"
  }
}
