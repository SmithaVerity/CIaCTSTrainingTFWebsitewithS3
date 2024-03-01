resource "aws_iam_instance_profile" "this" {
  name = "${var.environment}_ec2_role"
  role = aws_iam_role.ec2_role.name

  tags = var.tags
}

resource "aws_iam_role" "ec2_role" {
  name = "${var.environment}_ec2_role"

  assume_role_policy = data.aws_iam_policy_document.ec2_role.json

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "AmazonS3FullAccess" {
  policy_arn = data.aws_iam_policy.AmazonS3FullAccess.arn
  role       = aws_iam_role.ec2_role.name
}

resource "aws_iam_role_policy_attachment" "AmazonSSMManagedInstanceCore" {
  policy_arn = data.aws_iam_policy.AmazonSSMManagedInstanceCore.arn
  role       = aws_iam_role.ec2_role.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2FullAccess" {
  policy_arn = data.aws_iam_policy.AmazonEC2FullAccess.arn
  role       = aws_iam_role.ec2_role.name
}

resource "aws_instance" "this" {
  ami                         = data.aws_ami.ubuntu.id
  iam_instance_profile        = aws_iam_instance_profile.this.name
  instance_type               = "t2.micro"
  key_name                    = "CIaCTS_key"
  monitoring                  = true
  associate_public_ip_address = true
  subnet_id                   = module.vpc.private_subnets[1]

  vpc_security_group_ids       = [aws_security_group.this.id]

  metadata_options {
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 3
    http_tokens                 = "required"
  }

  tags = merge(var.tags, {
    "Name"        = var.environment
  })

  volume_tags = merge(var.tags, { "Name" = "${var.environment}_vol" })

  root_block_device {
    encrypted   = true
    volume_type = "gp3"
  }

  user_data = <<-EOF
      #!/bin/bash
      sudo apt-get update
      sudo apt-get install -y apache2
      sudo systemctl enable apache2
      sudo wget https://s3.amazonaws.com/mountpoint-s3-release/latest/x86_64/mount-s3.deb
      sudo apt-get install ./mount-s3.deb -y
      sudo rm -f ./mount-s3.deb
      sudo mkdir /mount_s3
      sudo mount-s3 ${module.s3.s3_bucket_id} /mount_s3
      git clone https://github.com/SmithaVerity/ABTestingApp.git
      mv ABTestingApp/cafe /var/www/html
    EOF

  lifecycle {
    ignore_changes = [user_data, ami, vpc_security_group_ids]
  }
}

resource "aws_security_group" "this" {
  name        = var.environment
  description = "${var.environment} security group for owncloud"
  vpc_id      = module.vpc.vpc_id

  tags = var.tags
}

resource "aws_security_group_rule" "egress" {
  from_port         = 0
  protocol          = -1
  security_group_id = aws_security_group.this.id
  to_port           = 0
  type              = "egress"

  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ingress22" {
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.this.id
  to_port           = 22
  type              = "ingress"

  cidr_blocks = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "ingress80" {
  from_port         = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.this.id
  to_port           = 80
  type              = "ingress"

  cidr_blocks = ["0.0.0.0/0"]
}
