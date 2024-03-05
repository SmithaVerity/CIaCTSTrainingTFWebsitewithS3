output "websiteURL" {
  value = format("%s%s", aws_instance.this.public_ip, "/cafe")
}
