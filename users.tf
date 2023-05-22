provider "aws" {
  region = "us-west-2"  # Replace with your desired region
}

resource "aws_iam_user" "admin_user" {
  name = "admin-user"  # Replace with the desired username
}


resource "aws_iam_user_policy_attachment" "admin_user_attachment" {
  user       = aws_iam_user.admin_user.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
