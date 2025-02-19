resource "aws_lb" "this" {
  name                       = var.lb_name
  internal                   = var.internal
  load_balancer_type         = var.lb_type
  security_groups            = var.security_groups
  subnets                    = var.subnets
  enable_deletion_protection = var.enable_deletion_protection
  tags                       = merge(var.tags, { "Name" = var.lb_name })
}

resource "aws_lb_target_group" "this" {
  name        = var.target_group_name
  port        = var.target_group_port
  protocol    = var.target_group_protocol
  vpc_id      = var.vpc_id
  target_type = var.target_type

  health_check {
    interval            = var.health_check_interval
    path                = var.health_check_path
    timeout             = var.health_check_timeout
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
  }
}

resource "aws_lb_target_group_attachment" "this" {
  count            = length(var.ec2_instance_ids)
  target_group_arn = aws_lb_target_group.this.arn
  target_id        = var.ec2_instance_ids[count.index]
  port             = var.target_group_port
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = var.listener_port
  protocol          = var.listener_protocol
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}
