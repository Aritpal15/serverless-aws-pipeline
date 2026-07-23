terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# 1. IAM Role for Lambda
resource "aws_iam_role" "lambda_exec" {
  name = "${var.function_name}-exec-role-v2"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# Attach basic execution policy for CloudWatch logging
resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# 2. Automatically Package the Lambda Code into a .zip File
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/../src/lambda_function.py"
  output_path = "${path.module}/lambda_function.zip"
}

# 3. AWS Lambda Function
resource "aws_lambda_function" "serverless_func" {
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = "${var.function_name}-v2"
  role             = aws_iam_role.lambda_exec.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.11"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
}

# 4. AWS Lambda Function URL (Direct HTTPS Endpoint)
resource "aws_lambda_function_url" "func_url" {
  function_name      = aws_lambda_function.serverless_func.function_name
  authorization_type = "NONE" # Publicly accessible endpoint

  cors {
    allow_credentials = true
    allow_origins     = ["*"]
    allow_methods     = ["GET", "POST"]
    allow_headers     = ["*"]
    max_age           = 86400
  }
}

# 5. Grant Public Invocation Permission to Function URL
resource "aws_lambda_permission" "allow_public_func_url" {
  statement_id           = "FunctionURLAllowPublicAccess"
  action                 = "lambda:InvokeFunctionUrl"
  function_name          = aws_lambda_function.serverless_func.function_name
  principal              = "*"
  function_url_auth_type = "NONE"
}