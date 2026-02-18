provider "aws" {
  region = "us-east-1"
}

# Security Group allowing SSH only from your IP
resource "aws_security_group" "sg_ssh" {
  name        = "project4-sg"
  description = "Allow SSH from my IP"
  
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["70.55.191.86/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 instance
resource "aws_instance" "web" {
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2 (us-east-1)
  instance_type = "t3.micro"
  security_groups = [aws_security_group.sg_ssh.name]

  tags = {
    Name = "Project4-EC2"
  }
}

# CloudWatch alarm for instance stopped / status check failure
resource "aws_cloudwatch_metric_alarm" "instance_stopped_alarm" {
  alarm_name          = "Project4-InstanceStopped"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "StatusCheckFailed_Instance"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Maximum"
  threshold           = "0"
  alarm_description   = "Alarm triggers if the EC2 instance is stopped or failing status checks"
  dimensions = {
    InstanceId = aws_instance.web.id
  }
}

