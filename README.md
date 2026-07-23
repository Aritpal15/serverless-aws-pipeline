# Serverless Microservice CI/CD Pipeline on AWS

A fully automated, production-ready serverless microservice pipeline built with **Infrastructure as Code (IaC)** using **Terraform** and deployed via **GitHub Actions**. Every push to `main` validates, plans, and deploys AWS infrastructure with zero manual console interaction.

---

## Overview

This project demonstrates a complete CI/CD workflow for deploying a serverless microservice on AWS Lambda, provisioned entirely through Terraform and automated with GitHub Actions. It's built around the principle that infrastructure changes should be reviewed, versioned, and deployed the same way application code is.

## Architecture & Workflow

```text
Developer Push → GitHub Actions → Terraform Validate & Plan → AWS Deployment → Public Function URL
```

Every commit to `main` triggers the pipeline automatically:

1. **Trigger** — `push` or `pull_request` events on the `main` branch kick off the workflow.
2. **Lint & Check** — `terraform fmt` and `terraform validate` catch formatting and configuration errors early.
3. **Execution Plan** — `terraform plan` previews exactly what will change before anything is applied.
4. **Automated Apply** — `terraform apply -auto-approve` provisions the AWS resources.

## Tech Stack

| Layer                  | Technology                                      |
| ---------------------- | ----------------------------------------------- |
| Cloud Infrastructure   | AWS Lambda, IAM Roles & Policies, Function URLs |
| Infrastructure as Code | Terraform (`>= 1.9.0`)                          |
| CI/CD Automation       | GitHub Actions                                  |
| Runtime                | Python 3.11                                     |

## Repository Structure

```text
.
├── .github/
│   └── workflows/
│       └── deploy.yml          # GitHub Actions CI/CD deployment pipeline
├── src/
│   └── lambda_function.py      # Microservice application code
├── terraform/
│   ├── main.tf                 # Primary Terraform configuration (IAM, Lambda, Function URL)
│   ├── variables.tf            # Input variable declarations
│   └── outputs.tf              # Output configurations (Function URL, Lambda ARN)
└── README.md                   # Project documentation
```

## Security & Best Practices

- **Zero Standing Access** — GitHub Actions authenticates to AWS using secure repository secrets, not long-lived credentials.
- **Least Privilege IAM** — Lambda execution roles are scoped tightly (`AWSLambdaBasicExecutionRole`), granting only what's needed.
- **Stateless Resiliency** — Resource names get a unique `random_id` suffix to avoid naming collisions across deployments.
- **CORS Safe** — Header, method, and origin controls are explicitly configured for cross-domain REST invocation.

## Prerequisites

- An AWS account with programmatic access configured
- [Terraform](https://developer.hashicorp.com/terraform/downloads) `>= 1.9.0`
- Python 3.11
- AWS credentials stored as GitHub repository secrets (for the CI/CD pipeline)

## Local Development & Testing

To test or deploy locally:

```bash
# Clone repository
git clone https://github.com/Aritpal15/serverless-aws-pipeline.git
cd serverless-aws-pipeline/terraform

# Initialize Terraform
terraform init

# Review execution plan
terraform plan

# Deploy infrastructure
terraform apply
```
