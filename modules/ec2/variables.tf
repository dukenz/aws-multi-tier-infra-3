variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "public_subnet_ids" {
  description = "IDs of the public subnets for the ALB"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "IDs of the private subnets for the ASG"
  type        = list(string)
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "asg_min" {
  description = "Minimum ASG instance count"
  type        = number
  default     = 1
}

variable "asg_max" {
  description = "Maximum ASG instance count"
  type        = number
  default     = 3
}

variable "asg_desired" {
  description = "Desired ASG instance count"
  type        = number
  default     = 2
}
