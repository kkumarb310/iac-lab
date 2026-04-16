# iac-lab — Claude Code project context

## Project overview
Terraform IaC project deploying AWS infrastructure for learning and portfolio.
AWS account: 459185600897
Region: ap-southeast-1
GitHub: https://github.com/kkumarb310/iac-lab
Plugin: https://github.com/kkumarb310/devops-iac-plugin

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
- dev.tfvars — dev environment values (no secrets)
- prod.tfvars — prod environment values (no secrets)

### Naming conventions
- Resource prefix: iac-lab-
- Local name for single-instance resources: "this"
- Module names: descriptive snake_case (e.g. s3_state, dynamodb_lock)

### Tagging — every resource must have these tags
- project = "iac-lab"
- env     = terraform.workspace (injected via local.workspace_tags)
- owner   = "ikshu"

Never use var.common_tags directly on resources — always use local.workspace_tags
so the env tag reflects the active workspace automatically.
Always use merge(var.tags, { Name = "${var.project}-descriptive-name" })
Never use tags = var.tags alone — always add a Name tag via merge.

### Module standards
- Input variables must have description and type — no exceptions
- Output values must have description — no exceptions
- Use "this" as the local resource name inside modules
- Stateful resources (S3, DynamoDB, RDS, EBS, VPC): always add prevent_destroy = true
- Always add ignore_changes = [tags] to resources managed by external systems
- S3 lifecycle configuration: always add ignore_changes = [rule] to prevent AWS API ordering drift
- Use for_each over count — always use stable string keys not numeric indexes
- Never put provider or terraform blocks inside modules — root only
- Add depends_on explicitly when AWS cannot infer the dependency
- Add timeouts block on known slow AWS APIs (S3 lifecycle, NAT gateway, RDS)
- sensitive = true on any variable or output containing passwords, keys, or connection strings

### State management
- Remote state: S3 bucket iac-lab-state-0ad57ae3
- State key pattern: {env}/terraform.tfstate
- Lock table: iac-lab-state-lock (DynamoDB)
- Never commit terraform.tfstate or .tfvars files

### Module output wiring pattern
Pass outputs from one module as inputs to the next:
  module.s3_state.bucket_name -> module.dynamodb_lock.state_bucket_name
  module.vpc.vpc_id -> module.ec2.vpc_id
  module.vpc.private_subnet_ids -> module.ec2.private_subnet_ids
  module.ec2.security_group_id -> module.rds.app_security_group_id

### Security standards
- Never use 0.0.0.0/0 on security group ingress without explicit justification comment
- Security group rules must use separate aws_security_group_rule resources
- IAM policies must follow least privilege
- RDS: always enable storage_encrypted = true, deletion_protection = true
- S3: always enable server_side_encryption and block_public_access
- Globally unique resources (S3 buckets): append random_id suffix

### CI/CD pipeline
- PR pipeline: fmt + TFLint + tfsec + terraform plan + Claude AI summary + Infracost
- Deploy pipeline: terraform apply via OIDC on merge to main
- Drift detection: weekly cron every Monday 1am UTC
- OIDC role: arn:aws:iam::459185600897:role/iac-lab-github-actions
- Infracost: posts monthly cost estimate per resource on every PR
- GitHub secrets: ANTHROPIC_API_KEY, TF_VAR_db_username, TF_VAR_db_password, INFRACOST_API_KEY

### Existing modules
- modules/s3 — S3 bucket with versioning, encryption, public access block, lifecycle rules
- modules/dynamodb — DynamoDB lock table, takes state_bucket_name as input
- modules/vpc — VPC with public/private subnets, IGW, NAT gateway, route tables, flow logs, default SG lockdown
- modules/ec2 — EC2 in private subnet, IMDSv2, encrypted gp3, egress-only SG
- modules/rds — RDS MySQL, private subnet, port 3306 from EC2 SG only, deletion_protection, storage_encrypted

## Claude behaviour instructions
- Always run terraform validate mentally before suggesting any HCL
- Always include description on every variable and output
- Always use local.workspace_tags for tags, never hardcode env values
- When generating a new module, always create all three files: main.tf, variables.tf, outputs.tf
- When refactoring existing resources into modules, remind user to run terraform state mv
- Update this CLAUDE.md whenever a new pattern is established
- Before creating any AWS resource, check if it already exists using the AWS MCP server
- After every apply check if new patterns were established and update this file
- Confirm prevent_destroy is present on every stateful resource when generating modules
- Confirm Infracost will pick up new resources correctly — avoid resource types not yet supported
