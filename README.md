# AWS Multi-Tier Infrastructure — Terraform

A production-grade, multi-tier AWS architecture deployed entirely through Terraform. Built as a portfolio project to demonstrate end-to-end cloud infrastructure skills including networking, compute, database, observability, and infrastructure-as-code best practices.

---

## Architecture Overview

```
                        ┌─────────────────────────────────────┐
                        │           AWS Cloud (us-east-1)      │
                        │                                     │
          Internet ──── │── Internet Gateway                  │
                        │         │                           │
                        │   ┌─────▼──────┐                   │
                        │   │ Public     │  NAT Gateway       │
                        │   │ Subnet     │──────────────┐     │
                        │   │ (EC2 ALB)  │              │     │
                        │   └─────┬──────┘              │     │
                        │         │                     │     │
                        │   ┌─────▼──────┐   ┌─────────▼───┐ │
                        │   │ Private    │   │  Private    │ │
                        │   │ Subnet     │   │  Subnet     │ │
                        │   │ (EC2 ASG)  │   │  (RDS PG)   │ │
                        │   └────────────┘   └─────────────┘ │
                        │                                     │
                        │   S3 (static assets) · CloudWatch   │
                        │   SNS (alerts) · IAM Roles          │
                        └─────────────────────────────────────┘
```

**Components:**
- VPC with public and private subnets across 2 Availability Zones
- Internet Gateway + NAT Gateway for controlled egress
- EC2 Auto Scaling Group behind an Application Load Balancer
- RDS PostgreSQL instance in a private subnet
- S3 bucket for static asset storage
- CloudWatch dashboards + alarms with SNS notifications
- IAM roles and security groups with least-privilege access

---

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) >= 1.5.0
- AWS CLI configured with appropriate credentials (`aws configure`)
- An AWS account with sufficient IAM permissions (EC2, RDS, VPC, S3, CloudWatch, SNS)

---

## Quickstart

```bash
# Clone the repo
git clone https://github.com/dukenz/aws-multi-tier-infra.git
cd aws-multi-tier-infra

# Initialize Terraform
terraform init

# Preview changes
terraform plan -var-file="environments/dev.tfvars"

# Deploy
terraform apply -var-file="environments/dev.tfvars"

# Tear down when done
terraform destroy -var-file="environments/dev.tfvars"
```

---

## Project Structure

```
aws-multi-tier-infra/
├── main.tf                  # Root module — wires everything together
├── variables.tf             # Input variable declarations
├── outputs.tf               # Exported values (ALB DNS, RDS endpoint, etc.)
├── providers.tf             # AWS provider + backend config
├── modules/
│   ├── vpc/                 # VPC, subnets, IGW, NAT, route tables
│   ├── ec2/                 # Launch template, ASG, ALB, security groups
│   ├── rds/                 # PostgreSQL instance, subnet group, parameter group
│   └── monitoring/          # CloudWatch dashboards, alarms, SNS topic
├── environments/
│   ├── dev.tfvars           # Dev environment variable overrides
│   └── staging.tfvars       # Staging environment variable overrides
└── diagrams/
    └── architecture.png     # Architecture diagram
```

---

## Module Breakdown

### `modules/vpc`
Creates the network foundation: a custom VPC with CIDR `10.0.0.0/16`, public and private subnets across two AZs, an Internet Gateway, a NAT Gateway for private subnet egress, and route tables.

### `modules/ec2`
Provisions an EC2 Launch Template with Amazon Linux 2, an Auto Scaling Group (min: 1, max: 3, desired: 2), an Application Load Balancer, and security groups scoped to required ports only.

### `modules/rds`
Deploys a PostgreSQL 14 RDS instance in the private subnet with automated backups enabled, a custom parameter group, and a DB subnet group spanning both AZs.

### `modules/monitoring`
Sets up CloudWatch dashboards for CPU utilization, network I/O, and RDS connections. Alarms trigger SNS notifications when CPU exceeds 80% or DB connections exceed threshold.

---

## Environments

Two `.tfvars` files allow one-command deployment to separate environments without touching core code:

| Variable | dev | staging |
|---|---|---|
| `instance_type` | t3.micro | t3.small |
| `db_instance_class` | db.t3.micro | db.t3.small |
| `asg_desired` | 1 | 2 |
| `multi_az` | false | true |

---

## Key Variables

| Variable | Description | Default |
|---|---|---|
| `aws_region` | AWS region to deploy into | `us-east-1` |
| `vpc_cidr` | CIDR block for the VPC | `10.0.0.0/16` |
| `instance_type` | EC2 instance type | `t3.micro` |
| `db_name` | RDS database name | `appdb` |
| `db_username` | RDS master username | `dbadmin` |
| `alarm_email` | Email for SNS CloudWatch alerts | — |

---

## Outputs

After `terraform apply`, the following values are exported:

```
alb_dns_name        = "app-alb-xxxx.us-east-1.elb.amazonaws.com"
rds_endpoint        = "appdb.xxxx.us-east-1.rds.amazonaws.com"
vpc_id              = "vpc-xxxxxxxxxxxxxxxxx"
s3_bucket_name      = "static-assets-xxxx"
cloudwatch_dashboard = "https://console.aws.amazon.com/cloudwatch/..."
```

---

## What I Learned

- **Module design matters.** Splitting resources into focused modules (`vpc`, `ec2`, `rds`, `monitoring`) makes the codebase maintainable and reusable — a single change in one module doesn't cascade unexpectedly.
- **Environment separation via `.tfvars` is cleaner than conditionals.** Using variable files per environment keeps the core Terraform DRY and makes environment-specific changes explicit and reviewable.
- **Least-privilege security groups take deliberate effort.** It's easy to open `0.0.0.0/0` and move on — scoping ingress/egress to exactly what's needed requires mapping out the actual traffic flows first.
- **CloudWatch alarms are only useful if they're actionable.** I learned to tune alarm thresholds against realistic baselines rather than arbitrary defaults, and to route alerts to SNS so they actually reach someone.
- **Terraform state is the source of truth.** Managing state carefully — using remote backends and understanding what `terraform plan` is telling you — is where real-world Terraform discipline lives.

---

## Certifications

This project aligns with objectives from:
- **AWS Certified Cloud Practitioner** — Cloud concepts, core services, security
- **HashiCorp Terraform Associate (003)** — IaC fundamentals, modules, state management

---

## Author

**Duke Nzekwe** — Cybersecurity & Cloud Professional, Houston TX  
[LinkedIn](https://linkedin.com/in/dukenzekwe) · [GitHub](https://github.com/dukenz)  
`dukenzekwe23@gmail.com`
