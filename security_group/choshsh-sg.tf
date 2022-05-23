module "choshsh" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "choshsh"
  description = "Security group for user-service with custom ports open within VPC, and PostgreSQL publicly open"
  vpc_id      = var.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      description = "choshsh home"
      cidr_blocks = "58.124.31.172/32"
    },
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "choshsh home"
      cidr_blocks = "58.124.31.172/32"

    }
  ]
}
