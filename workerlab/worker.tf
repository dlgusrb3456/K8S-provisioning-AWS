resource "aws_launch_configuration" "worker" {
  image_id                      = "ami-06e71a1e6ee290060"
  instance_type                 = "t2.medium"
  key_name                      = "terraform_test_rsa"
  security_groups               = ["${data.aws_security_group.selected.id}"]
  lifecycle     {
    create_before_destroy       = true
  }
  user_data = file("./worker_install_k8s.sh")
}

data "aws_security_group" "selected" {
  name = "terraform"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

resource "aws_autoscaling_policy" "worker_policy" {
  autoscaling_group_name = aws_autoscaling_group.worker.name
  name                   = "auto_policy"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 1
  policy_type            = "SimpleScaling"
  cooldown               = 300
}

resource "aws_cloudwatch_metric_alarm" "bat" {
  alarm_name          = "terraform-test-foobar5"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "30"
  statistic           = "Average"
  threshold           = "50"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.worker.name
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = [aws_autoscaling_policy.worker_policy.arn]
}

resource "aws_autoscaling_group" "worker" {
  launch_configuration = aws_launch_configuration.worker.name
  vpc_zone_identifier = data.aws_subnet_ids.default.ids
  min_size = 1
  max_size = 2
  tag {
                key = "Name"
                value = "terraform-asg-example"
                propagate_at_launch = true
  }
}
