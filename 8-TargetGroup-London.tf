
resource "aws_lb_target_group" "app1_tg-London" {
    provider = aws.eu-west-2
  name     = "app1-tg-London"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.app1-London.id
  target_type = "instance"

  health_check {
    enabled             = true
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    matcher             = "200"
  }

  tags = {
    Name    = "App1TargetGroup-London"
    Service = "J-Tele-Doctor"
  }
}