locals {
  name_prefix = "${var.environment}-${var.project}"
  alb_sg_name = var.alb_sg_name != "" ? var.alb_sg_name : "${var.project}-alb-sg"
}

# ALB Security Group — allows inbound HTTP/HTTPS from the internet
resource "aws_security_group" "alb" {
  name        = local.alb_sg_name
  description = "Allow HTTP/HTTPS inbound to ALB"
  vpc_id      = var.vpc_id

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = local.alb_sg_name
  })
}

# ECS Task Security Group — allows inbound only from the ALB SG on container port
resource "aws_security_group" "ecs_tasks" {
  name        = var.ecs_sg_name
  description = "Allow inbound from ALB to ECS tasks on container port"
  vpc_id      = var.vpc_id

  ingress {
    description     = "Container port from ALB"
    from_port       = var.container_port
    to_port         = var.container_port
    protocol        = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = var.ecs_sg_name
  })
}
