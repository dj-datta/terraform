provider "aws" {
  region = "us-east-1"
}

resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["sg-0b97c932cb4f000dc"]
  subnets            = ["subnet-06f7cfc0f810e5532"] ["subnet-06f73cc51b3c96d64"]

  enable_deletion_protection = true

  access_logs {
    bucket  = "http://mybuckdj.s3-website-us-east-1.amazonaws.com"
    prefix  = "test-lb"
    enabled = true
  }

  tags = {
    Environment = "production"
  }
}