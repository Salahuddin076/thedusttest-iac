# ── Shared VPC (owned by dev environment — reused for cost optimisation) ──────
data "aws_vpc" "shared" {
  tags = {
    Name = "${var.project}-vpc"
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.shared.id]
  }
  tags = {
    Type = "public"
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.shared.id]
  }
  tags = {
    Type = "private"
  }
}
