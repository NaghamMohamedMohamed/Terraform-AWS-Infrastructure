resource "aws_iam_role" "lambda_role" {
  name = "${var.env_name}-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole",
      Effect    = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "lambda-function.py"
  output_path = "hello-world-lambda.zip"
}

resource "aws_lambda_function" "hello" {
  filename         = "hello-world-lambda.zip"
  function_name    = "${var.env_name}-hello-world"
  role             = aws_iam_role.lambda_role.arn
  handler          = "lambda-function.lambda_handler"
  runtime          = "python3.8"
  source_code_hash = filebase64sha256("lambda_function_payload.zip")
  tags = {
    Name = "${var.env_name}-lambdafun"
  }
}
