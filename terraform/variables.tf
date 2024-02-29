variable "environment" {
  description = "Environment name for project"
  type        = string

  default = "ciacts_s3_mountpoint"
}

variable "region" {
  description = "AWS Region where resources will be deployed"
  type        = string

  default = "ap-south-1"
}

variable "tags" {
  description = "Tags to be applied to resources"
  type        = map(string)

  default = {}
}
