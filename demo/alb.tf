provider "aws" {
  region = "us-east-1"
}
resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["sg-0b97c932cb4f000dc"]
  subnets            = ["subnet-06f7cfc0f810e5532"]

  enable_deletion_protection = true

  access_logs {
    bucket  = arn:aws:s3:::mybuckdj
    prefix  = "test-lb"
    enabled = true
  }

  tags = {
    Environment = "production"
  }
}