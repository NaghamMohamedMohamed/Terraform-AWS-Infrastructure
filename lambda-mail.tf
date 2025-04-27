resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_exec_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Principal = {
        Service = "lambda.amazonaws.com"
      },
      Effect = "Allow",
      Sid = ""
    }]
  })
}

resource "aws_iam_policy" "lambda_policy" {
  name = "lambda_send_email_policy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ses:SendEmail",
          "ses:SendRawEmail"
        ],
        Resource = ""
      },
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ],
        Resource = ""
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

data "archive_file" "lambda-mail" {
  type        = "zip"
  source_file = "send-mail.py"
  output_path = "send_email_lambda.zip"
}
resource "aws_lambda_function" "send_email_on_s3_change" {
  function_name = "SendEmailOnS3Change"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "send-mail.lambda_handler"
  runtime       = "python3.11"

  filename      = "./send_email_lambda.zip"

  environment {
    variables = {
      SOURCE_EMAIL      = "naghamfakhreldin@gmail.com"
      DESTINATION_EMAIL = "naghamfakhreldin@gmail.com"
    }
  }
}