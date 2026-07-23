variable "aws_region" {
  description = "The AWS region where resources will be deployed"
  type        = string
  default     = "ap-south-1"
}

variable "function_name" {
  description = "The name of the AWS Lambda function"
  type        = string
  default     = "serverless-pipeline-func"
}