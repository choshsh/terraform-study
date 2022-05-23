module "sg" {
  source = "./security_group"

  vpc_id = var.vpc_id
}

module "iam" {
  source = "./iam"
}
