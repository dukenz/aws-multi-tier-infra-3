module "vpc" {
  source = "./modules/vpc"

  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}

module "ec2" {
  source = "./modules/ec2"

  environment       = var.environment
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  instance_type     = var.instance_type
  asg_min           = var.asg_min
  asg_max           = var.asg_max
  asg_desired       = var.asg_desired
}

module "rds" {
  source = "./modules/rds"

  environment        = var.environment
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  ec2_sg_id          = module.ec2.ec2_security_group_id
  db_name            = var.db_name
  db_username        = var.db_username
  db_password        = var.db_password
  db_instance_class  = var.db_instance_class
  multi_az           = var.multi_az
}

module "monitoring" {
  source = "./modules/monitoring"

  environment         = var.environment
  asg_name            = module.ec2.asg_name
  rds_identifier      = module.rds.db_identifier
  alb_arn_suffix      = module.ec2.alb_arn_suffix
  alarm_email         = var.alarm_email
  cpu_alarm_threshold = var.cpu_alarm_threshold
}
