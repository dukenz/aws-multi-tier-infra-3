# environments/dev.tfvars
# Lightweight, cost-optimized settings for development

aws_region  = "us-east-1"
environment = "dev"

# Networking
vpc_cidr             = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.10.0/24", "10.0.11.0/24"]
availability_zones   = ["us-east-1a", "us-east-1b"]

# Compute — smallest viable instances
instance_type = "t3.micro"
asg_min       = 1
asg_max       = 2
asg_desired   = 1

# Database — single-AZ, smallest class
db_name           = "appdb"
db_username       = "dbadmin"
db_instance_class = "db.t3.micro"
multi_az          = false

# Monitoring
alarm_email         = "dukenzekwe23@gmail.com"
cpu_alarm_threshold = 80
