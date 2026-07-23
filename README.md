Serverless Microservice CI/CD Pipeline on AWS
A fully automated, production-ready serverless microservice pipeline built with Infrastructure as Code (IaC) using Terraform and deployed seamlessly via GitHub Actions.
---
🎯 Architecture & Workflow
The architecture follows a modern serverless design pattern. Every commit pushed to the `main` branch automatically triggers the CI/CD pipeline to validate, plan, and deploy cloud infrastructure without manual console interaction.
```text
[ Developer Push ] ➡️ [ GitHub Actions ] ➡️ [ Terraform Validate & Plan ] ➡️ [ AWS Deployment ] ➡️ [ Public Function URL ]
```
Tech Stack
Cloud Infrastructure: AWS Lambda, IAM Roles & Policies, Function URLs
Infrastructure as Code (IaC): Terraform (`>= 1.9.0`)
CI/CD Automation: GitHub Actions
Runtime: Python 3.11
---
📁 Repository Structure
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
---
🚀 Deployment Pipeline Details
Trigger: `push` or `pull_request` on `main` branch.
Lint & Check: Formats (`terraform fmt`) and validates (`terraform validate`) IaC configurations.
Execution Plan: Runs `terraform plan` to preview infrastructure modifications.
Automated Apply: Executes `terraform apply -auto-approve` to provision AWS resources dynamically.
---
🔒 Security & Best Practices
Zero Standing Access: Authenticates GitHub Actions using secure repository secrets.
Granular Scope: IAM Execution Roles follow the Principle of Least Privilege (`AWSLambdaBasicExecutionRole`).
Stateless Resiliency: Dynamically appends unique resource tags via `random_id` to eliminate deployment naming collisions.
CORS Safe: Strict header, method, and origin controls configured for cross-domain REST invocation.
---
🛠️ Local Development & Testing
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