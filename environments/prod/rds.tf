# ── RDS VPC (default VPC where prod-thedusttest lives) ───────────────────────
data "aws_vpc" "rds" {
  id = "vpc-07e0d675dd0007db5"
}

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

# ── VPC Peering: ECS VPC (13.0.0.0/16) ↔ RDS VPC (172.31.0.0/16) ────────────
resource "aws_vpc_peering_connection" "ecs_to_rds" {
  vpc_id      = data.aws_vpc.shared.id
  peer_vpc_id = data.aws_vpc.rds.id
  auto_accept = true

  # Without these, the RDS hostname resolves to its public IP from the ECS VPC
  # and the connection is blocked. These make it resolve to the private IP.
  requester {
    allow_remote_vpc_dns_resolution = true
  }

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  tags = merge(local.common_tags, {
    Name = "${var.project}-ecs-to-rds-peering"
  })
}

# ── Routes ────────────────────────────────────────────────────────────────────

# ECS private subnets → RDS VPC via peering
resource "aws_route" "ecs_private_to_rds" {
  route_table_id            = "rtb-02af79856cb1bfb43" # dev-thedusttest-private-rt
  destination_cidr_block    = data.aws_vpc.rds.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.ecs_to_rds.id
}

# RDS VPC main RT → ECS VPC via peering
resource "aws_route" "rds_to_ecs" {
  route_table_id            = "rtb-0ef9a2b7bbdce0e85" # RDS VPC main route table
  destination_cidr_block    = data.aws_vpc.shared.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.ecs_to_rds.id
}

# ── RDS Security Group — allow MySQL from ECS VPC CIDR (peering) ─────────────
resource "aws_security_group_rule" "rds_from_ecs_vpc" {
  type              = "ingress"
  security_group_id = "sg-05487522410ce7e59" # prod-rds-thedustest SG
  description       = "MySQL from tdt ECS tasks (thedusttest-vpc 13.0.0.0/16)"
  protocol          = "tcp"
  from_port         = 3306
  to_port           = 3306
  cidr_blocks       = [data.aws_vpc.shared.cidr_block]
}

# ── RDS Security Group — allow MySQL from ECS NAT Gateway public IP ───────────
# ECS tasks in private subnets egress via the NAT GW (fixed EIP 3.18.208.242).
# This rule is the direct path: ECS → NAT GW → RDS public endpoint.
resource "aws_security_group_rule" "rds_from_ecs_nat" {
  type              = "ingress"
  security_group_id = "sg-05487522410ce7e59"
  description       = "MySQL from ECS NAT Gateway EIP (3.18.208.242)"
  protocol          = "tcp"
  from_port         = 3306
  to_port           = 3306
  cidr_blocks       = ["3.18.208.242/32"]
}
