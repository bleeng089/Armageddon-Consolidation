resource "aws_lb" "app1_alb-London" {
    provider = aws.eu-west-2
  name               = "app1-alb-London"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.app1-sg-LB01-London.id]
  subnets            = [
    aws_subnet.public-eu-west-2a.id,
    aws_subnet.public-eu-west-2b.id
  ]
  enable_deletion_protection = false
#Lots of death and suffering here, make sure it's false. Prevents terraform from deleting the load balancer, prevents accidental deletions

  tags = {
    Name    = "App1LoadBalancer-London"
  }
}
resource "aws_lb_listener" "https-London" {
    provider = aws.eu-west-2
  load_balancer_arn = aws_lb.app1_alb-London.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app1_tg-London.arn
  }
}

output "LB-London" { # London dns name
  value     =  aws_lb.app1_alb-London.dns_name
}


