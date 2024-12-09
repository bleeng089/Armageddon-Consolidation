resource "aws_lb" "app1_alb-Brazil" {
    provider = aws.sa-east-1
  name               = "app1-alb-Brazil"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.app1-sg-LB01-Brazil.id]
  subnets            = [
    aws_subnet.public-sa-east-1a.id,
    aws_subnet.public-sa-east-1b.id
  ]
  enable_deletion_protection = false
#Lots of death and suffering here, make sure it's false. Prevents terraform from deleting the load balancer, prevents accidental deletions

  tags = {
    Name    = "App1LoadBalancer-Brazil"
  }
}
resource "aws_lb_listener" "https-Brazil" {
    provider = aws.sa-east-1
  load_balancer_arn = aws_lb.app1_alb-Brazil.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app1_tg-Brazil.arn
  }
}

output "LB-Brazil" { # Brazil dns name
  value     =  aws_lb.app1_alb-Brazil.dns_name
}


