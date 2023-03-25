resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "my-vpc"
  }
}

resource "aws_subnet" "subnet" {
  count = length(var.subnet_cidr_blocks)

  cidr_block = var.subnet_cidr_blocks[count.index]
  vpc_id     = aws_vpc.vpc.id
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "my-subnet-${count.index + 1}"
  }
}

data "aws_availability_zones" "available" {}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "my-internet-gateway"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = "my-route-table"
  }
}

resource "aws_route_table_association" "route_table_association" {
  count = length(aws_subnet.subnet)

  subnet_id      = aws_subnet.subnet[count.index].id
  route_table_id = aws_route_table.route_table.id
}



resource "aws_security_group" "security_group" {
  name_prefix = "my-security-group"
  description = "My security group"

  ingress {
    from_port   = var.port
    to_port     = var.port
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vpc.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "my-security-group"
  }
}

resource "aws_lb" "load_balancer" {
  name               = "my-load-balancer"
  internal           = false
  load_balancer_type = "application"

  subnet_mapping {
    subnet_id = aws_subnet.subnet[0].id
  }

  security_groups = [aws_security_group.security_group.id]

  tags = {
    Name = "my-load-balancer"
  }
}

resource "aws_lb_target_group" "target_group" {
  name_prefix      = "rctgrp"
  port             = var.port
  protocol         = "HTTP"
  vpc_id           = aws_vpc.vpc.id
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 5
    interval            = 30
    timeout             = 5
    protocol            = "HTTP"
    path                = "/health"
    matcher             = "200"
  }
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

resource "aws_ecs_cluster" "cluster" {
  name = "my-ecs"

}