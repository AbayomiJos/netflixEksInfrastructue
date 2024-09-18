# EC2 Instance in Netflix Public Subnet 1
resource "aws_instance" "netflix_public_instance_1" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.netflix_public_subnet_1.id
  vpc_security_group_ids = [aws_security_group.netflix_public_sg.id]
  key_name               = var.key_name

  tags = {
    Name = "netflix-public-instance-1"
  }
}

/*# EC2 Instance in Netflix Public Subnet 2
resource "aws_instance" "netflix_public_instance_2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.netflix_public_subnet_2.id
  vpc_security_group_ids = [aws_security_group.netflix_public_sg.id]
  key_name               = var.key_name

  tags = {
    Name = "netflix-public-instance-2"
  }
}*/


