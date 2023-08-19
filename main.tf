# ---root/main.tf---

module "networking" {
  source       = "./networking"
  vpc_cidr     = "10.10.0.0/16"
  public_cidr  = ["10.10.2.0/24", "10.10.4.0/24"]
  private_cidr = ["10.10.3.0/24", "10.10.5.0/24", "10.10.7.0/24"]
  access_ip    = var.access_ip
  security_groups = locals.security_groups
}
