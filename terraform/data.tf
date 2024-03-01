data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
data "aws_availability_zones" "this" {}

data "aws_caller_identity" "this" {}

data "aws_iam_policy" "AmazonSSMManagedInstanceCore" {
  name = "AmazonSSMManagedInstanceCore"
}

data "aws_iam_policy" "AmazonEC2FullAccess" {
  name = "AmazonEC2FullAccess"
}

data "aws_iam_policy" "AmazonS3FullAccess" {
  name = "AmazonS3FullAccess"
}

data "aws_iam_policy_document" "ec2_role" {
  statement {
    effect = "Allow"
    principals {
      identifiers = ["ec2.amazonaws.com"]
      type        = "Service"
    }
    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "s3_access" {
  statement {
    effect  = "Allow"
    actions = [
        "s3:*",
        "s3-object-lambda:*"
    ]
    resources = [
      module.s3.s3_bucket_arn,
      "${module.s3.s3_bucket_arn}/*"
    ]
  }
}

data "aws_region" "current" {}
