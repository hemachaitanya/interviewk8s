provider "aws" {
    region = "us-east-1"
}
resource "aws_iam_role" "hema" {
    name = "hema-role"
    assume_role_policy = jsondecode({
        version = "2012-0-17"
        statement = [{
            Effect = "Allow"
            Principal = {
                Service = "lambda.amazonaws.com"
            },
            Action = "sts:AssumeRole"
        }]
    })
}
resource "aws_iam_policy_attachment" "hema_policy" {
    name = "ec2_controle_policy_attach"
    roles = [aws_iam_role.hema.name]
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}
resource "aws_lambda_function" "hema" {
  
}