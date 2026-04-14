resource "aws_db_subnet_group" "this" {
  name       = "${var.project}-db-subnet-group"
  subnet_ids = values(var.private_subnet_ids)

  tags = merge(var.tags, {
    Name = "${var.project}-db-subnet-group"
  })
}

resource "aws_security_group" "this" {
  name        = "${var.project}-rds-sg"
  description = "Security group for RDS MySQL - allows 3306 from app SG only"
  vpc_id      = var.vpc_id

  tags = merge(var.tags, {
    Name = "${var.project}-rds-sg"
  })
}

resource "aws_security_group_rule" "mysql_ingress" {
  description              = "Allow MySQL from application security group"
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = var.app_security_group_id
  security_group_id        = aws_security_group.this.id
}

resource "aws_security_group_rule" "all_egress" {
  description       = "Allow all outbound traffic"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.this.id
}

resource "aws_db_instance" "this" {
  identifier     = "${var.project}-mysql"
  engine         = "mysql"
  engine_version = var.engine_version
  instance_class = var.instance_class

  allocated_storage = var.allocated_storage
  storage_type      = "gp3"
  storage_encrypted = true

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [aws_security_group.this.id]
  multi_az               = false
  publicly_accessible    = false

  deletion_protection = true
  skip_final_snapshot = false
  final_snapshot_identifier = "${var.project}-mysql-final-snapshot"

  backup_retention_period = 0
  backup_window           = "03:00-04:00"
  maintenance_window      = "sun:04:30-sun:05:30"

  tags = merge(var.tags, {
    Name = "${var.project}-mysql"
  })

  timeouts {
    create = "40m"
    update = "40m"
    delete = "40m"
  }

  lifecycle {
    prevent_destroy = true
  }

  depends_on = [aws_db_subnet_group.this]
}
