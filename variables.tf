variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_1_cidr" {
  description = "CIDR block for public subnet 1"
  default     = "10.0.1.0/24"
}

variable "public_subnet_2_cidr" {
  description = "CIDR block for public subnet 2"
  default     = "10.0.2.0/24"
}

variable "private_subnet_1_cidr" {
  description = "CIDR block for private subnet 1"
  default     = "10.0.3.0/24"
}

variable "private_subnet_2_cidr" {
  description = "CIDR block for private subnet 2"
  default     = "10.0.4.0/24"
}

variable "availability_zone_1" {
  description = "Availability Zone for public subnet 1"
  default     = "us-west-1b"
}

variable "availability_zone_2" {
  description = "Availability Zone for public subnet 2"
  default     = "us-west-1c"
}

variable "ami_id" {
  description = "AMI ID for worker nodes"
  default     = "ami-04fdea8e25817cd69"  # Amazon Linux 2 AMI
}

variable "instance_type" {
  description = "Instance type for the EKS worker nodes"
  default     = "t2.medium"
}

variable "key_name" {
  description = "Key pair name for SSH access to worker nodes"
  default     = "netflixKeyPair"
}
