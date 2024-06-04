provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "app_server" {
  ami           = "ami-00beae93a2d981137"  # Replace with a valid AMI ID
  instance_type = "t2.micro"

  tags = {
    Name = "AppServer"
  }
}
