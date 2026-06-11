# ── RDS DB Instance (imported — never mutated by Terraform) ──────────────────
resource "aws_db_instance" "prod" {
  identifier             = "prod-thedusttest"
  engine                 = "mysql"
  engine_version         = "8.0.44"
  instance_class         = "db.t4g.micro"
  db_name                = "prod_thedusttest"
  username               = "admin"
  password               = "managed-outside-terraform"
  allocated_storage      = 100
  storage_type           = "io2"
  iops                   = 1000
  storage_encrypted      = true
  db_subnet_group_name   = "default-vpc-07e0d675dd0007db5"
  vpc_security_group_ids = ["sg-05487522410ce7e59"]
  skip_final_snapshot    = false
  deletion_protection    = true

  tags = local.common_tags

  lifecycle {
    ignore_changes  = all
    prevent_destroy = true
  }
}

# ── RDS Security Group ────────────────────────────────────────────────────────
# ECS tasks are in private subnets and egress via NAT Gateway (fixed EIP).
# The RDS is in a different VPC so its SG sees the NAT GW public IP, not 13.x.x.x.
resource "aws_security_group_rule" "rds_from_ecs_vpc" {
  type              = "ingress"
  security_group_id = tolist(aws_db_instance.prod.vpc_security_group_ids)[0]
  description       = "MySQL from ECS tasks (shared VPC CIDR)"
  protocol          = "tcp"
  from_port         = 3306
  to_port           = 3306
  cidr_blocks       = [data.aws_vpc.shared.cidr_block]
}

resource "aws_security_group_rule" "rds_from_nat_gw" {
  type              = "ingress"
  security_group_id = tolist(aws_db_instance.prod.vpc_security_group_ids)[0]
  description       = "MySQL from ECS NAT Gateway EIP - actual source IP for cross-VPC traffic"
  protocol          = "tcp"
  from_port         = 3306
  to_port           = 3306
  cidr_blocks       = ["${var.nat_gateway_eip}/32"]
}
