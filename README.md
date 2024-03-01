# AWS EC2 Webapp with S3 Mount Point with Terraform

## Resources Created
* **VPC with S3 Endpoint:** Network resources and endpoint for S3 access.
* **S3 Bucket:** The bucket to be mounted.
* **S3 Object:** A text file within the S3 bucket.
* **IAM Policies:** Required permissions for the EC2 instance to access the S3 bucket.
* **EC2 Instance with Ubuntu:** Instance where the S3 bucket will be mounted.

## Getting Started
Clone this repository and navigate into the project directory.

## Initialize Terraform
To download and initialize the necessary providers and modules, run:

```bash
terraform init
```

## Plan Your Changes
Review the changes before applying with:

```bash
terraform plan -out=plan.out
```

## Apply the Changes
Apply the planned changes:

```bash
terraform apply plan.out
```

## Testing


## Destroy the Resources to cleanup
When you're done experimenting, you can destroy all created resources with:

```bash
terraform destroy
```
