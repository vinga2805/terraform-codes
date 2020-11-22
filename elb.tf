resource "aws_elb" "elb" {
  name               = "demo-app-elb"
  subnets = [aws_subnet.sub1.id, aws_subnet.sub3.id]
  security_groups = [aws_security_group.lb.id]
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }


  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 2
    target              = "HTTP:80/health.html"
    interval            = 5
  }

  instances                   = [aws_instance.app1.id, aws_instance.app2.id]
  cross_zone_load_balancing   = true
  idle_timeout                = 60
  connection_draining         = true
  connection_draining_timeout = 60

  tags = {
    Name = "demo-app-elb"
    Environment = "stage"
  }
}
