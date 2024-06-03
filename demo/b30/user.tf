provider "aws" {
  region = "us-east-1"
}
resource "aws_iam_user" "example" {
  name          = "example"
  path          = "/"
  force_destroy = true
}

resource "aws_iam_user_login_profile" "example" {
  user    = "example"
  pgp_key = "keybase:some_person_that_exists"
}

output "password" {
  value = "User123"
}