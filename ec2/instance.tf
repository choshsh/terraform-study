locals {
  home_ip = "58.124.31.172/32"
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_eip" "choshsh" {
  vpc = true
  tags = {
    "Name" = "choshsh"
  }
}

resource "aws_eip_association" "choshsh" {
  instance_id   = module.ec2_instance.id
  allocation_id = aws_eip.choshsh.id
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 4.0"

  name                        = "choshsh-instance"
  ami                         = "ami-02c3627b04781eada"
  instance_type               = "t2.micro"
  key_name                    = "MyKeyPair"
  user_data                   = file("${path.module}/init_instance.sh")
  user_data_replace_on_change = true

  vpc_security_group_ids = [module.ec2_sg.security_group_id]

  root_block_device = [
    {
      volume_type : "gp3"
      volume_size : "10"
    }
  ]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }

  depends_on = [
    module.ec2_sg
  ]
}

# EC2 보안그룹
module "ec2_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "ec2-custom-sg"
  description = "Security group for ec2"
  vpc_id      = data.aws_vpc.default.id

  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "my home"
      cidr_blocks = local.home_ip
    },
  ]

  egress_rules = ["all-all"]
}

output "ec2_public_dns" {
  value = module.ec2_instance.public_dns
}
