# --- AMI lookup (Amazon Linux 2023, latest) ---
data "aws_ami" "amazon_linux" {
  count = var.ami_id == "" ? 1 : 0

  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

locals {
  ami_id = var.ami_id != "" ? var.ami_id : data.aws_ami.amazon_linux[0].id
}

# --- Security Group ---
resource "aws_security_group" "this" {
  name        = "${var.project}-ec2-sg"
  description = "Security group for ${var.project} EC2 instance"
  vpc_id      = var.vpc_id

  tags = merge(var.tags, {
    Name = "${var.project}-ec2-sg"
  })
}

# Egress: allow all outbound (required for package updates via NAT)
resource "aws_security_group_rule" "egress_all" {
  description       = "Allow all outbound traffic"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.this.id
}

# --- EC2 Instance ---
resource "aws_instance" "this" {
  ami                    = local.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.private_subnet_ids[var.subnet_key]
  vpc_security_group_ids = [aws_security_group.this.id]

  metadata_options {
    http_tokens   = "required"
    http_endpoint = "enabled"
  }

  root_block_device {
    volume_type = "gp3"
    volume_size = 8
    encrypted   = true
  }

  tags = merge(var.tags, {
    Name = "${var.project}-ec2"
  })

  lifecycle {
    ignore_changes = [ami]
  }
}
