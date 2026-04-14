# iac-lab — Claude Code project context

## Project overview
Terraform IaC project deploying AWS infrastructure for learning and portfolio.
AWS account: 459185600897
Region: ap-southeast-1
GitHub: https://github.com/kkumarb310/iac-lab

## Terraform standards

### Version requirements
- Terraform >= 1.7.0
- AWS provider ~> 5.0
- Random provider ~> 3.0

### File structure — always use this layout
Every module must have exactly three files:
- main.tf — resources only
- variables.tf — input variables with description and type
- outputs.tf — output values with description

Root module additional files:
- backend.tf — S3 remote state configuration
- dev.tfvars — dev environment values
- prod.tfvars — prod environment values

### Naming conventions
- Resource prefix: iac-lab-
- Local name for single-instance resources: "this"
- Local name for root-level resources: descriptive (e.g. "terraform_lock")
- Module names: descriptive snake_case (e.g. "s3_state", "dynamodb_lock")

### Tagging — every resource must have these tags
- project = "iac-lab"
- env     = terraform.workspace (injected via local.workspace_tags)
- owner   = "ikshu"

Never use var.common_tags directly on resources — always use local.workspace_tags
so the env tag reflects the active workspace automatically.

### Module standards
- Input variables must have description and type — no exceptions
- Output values must have description — no exceptions
- Use "this" as the local resource name inside modules
- Stateful resources (S3, DynamoDB, RDS, EBS, VPC): always add prevent_destroy = true
- Always add ignore_changes = [tags] to resources managed by external systems
- Use for_each over count — always use stable string keys not numeric indexes

### State management
- Remote state: S3 bucket iac-lab-state-0ad57ae3
- State key pattern: {env}/terraform.tfstate
- Lock table: iac-lab-state-lock (DynamoDB)
- Never commit terraform.tfstate or .tfvars files

### Module output wiring pattern
Pass outputs from one module as inputs to the next:
  module.s3_state.bucket_name → module.dynamodb_lock.state_bucket_name

### Existing modules
- modules/s3 — S3 bucket with versioning, encryption, public access block, lifecycle rules
- modules/dynamodb — DynamoDB lock table, takes state_bucket_name as input
- modules/vpc — VPC with public/private subnets, IGW, NAT gateway, route tables across 2 AZs
- modules/ec2 — EC2 instance in private subnet with security group, takes vpc_id and private_subnet_ids from VPC module

## Claude behaviour instructions
- Always run terraform validate mentally before suggesting any HCL
- Always include description on every variable and output
- Always use local.workspace_tags for tags, never hardcode env values
- When generating a new module, always create all three files: main.tf, variables.tf, outputs.tf
- When refactoring existing resources into modules, remind me to run terraform state mv
- Update this CLAUDE.md whenever a new pattern is established
- Before creating any AWS resource, check if it already exists using the AWS MCP server
