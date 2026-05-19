# environments/staging.tfvars
# Production-like settings for pre-release validation

aws_region  = "us-east-1"
environment = "staging"

# Networking — same CIDR, separate VPC per environment
vpc_cidr             = "10.1.0.0/16"
public_subnet_cidrs  = ["10.1.1.0/24", "10.1.2.0/24"]
private_subnet_cidrs = ["10.1.10.0/24", "10.1.11.0/24"]
availability_zones   = ["us-east-1a", "us-east-1b"]

# Compute — larger instances, higher desired count
instance_type = "t3.small"
asg_min       = 1
asg_max       = 4
asg_desired   = 2

# Database — Multi-AZ for resilience testing
db_name           = "appdb"
db_username       = "dbadmin"
db_instance_class = "db.t3.small"
multi_az          = true

# Monitoring — tighter alarm threshold
alarm_email         = "dukenzekwe23@gmail.com"
cpu_alarm_threshold = 70
