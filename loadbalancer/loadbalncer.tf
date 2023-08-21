resource "aws_lb" "k3_alb" {
  name               = "k3-alb"
  internal           = false
  load_balancer_type = "application"
  subnets            = [var.public_subnet]
  security_groups    = [var.public_sg]
  idle_timeout       = 400

  tags = {
    company = "k3_alb"
  }
}

resource "aws_lb_target_group" "k3_alb_tg" {
  name     = "k3-alb-tg-$(substr(uuid(),0,3))"
  port     = var.tg_port
  protocol = var.tg_protocol
  vpc_id   = var.vpc_id
  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
  }
  lifecycle_policies {
    ignore_changes        = [name]
    create_before_destroy = true
  }
}

resource "aws_lb_listner" "k3_alb_listner" {
  load_balancer_arn = aws_lb.k3_alb.arn
  port              = var.tg_port
  protocol          = var.tg_protocol
  default_actipn    = "forward"
  target_group_arn  = aws_lb_target_group.k3_alb_tg.arn
}