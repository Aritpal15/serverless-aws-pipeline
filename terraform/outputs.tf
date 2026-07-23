output "lambda_function_url" {
  description = "The public HTTPS endpoint URL for the AWS Lambda function"
  value       = aws_lambda_function_url.func_url.function_url
}

output "lambda_function_arn" {
  description = "The ARN of the AWS Lambda function"
  value       = aws_lambda_function.serverless_func.arn
}