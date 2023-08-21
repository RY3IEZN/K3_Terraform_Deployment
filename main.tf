# ---root/main.tf---

module "networking" {
  source          = "./networking"
  vpc_cidr        = "10.10.0.0/16"
  public_cidr     = ["10.10.2.0/24", "10.10.4.0/24"]
  private_cidr    = ["10.10.3.0/24", "10.10.5.0/24", "10.10.7.0/24"]
  access_ip       = var.access_ip
  security_groups = locals.security_groups
}

module "database" {
  source                  = "./database"
  allocated_storage       = 10
  engine                  = "mysql"
  engine_version          = "5.7"
  instance_class          = "db.t2.micro"
  db_name                 = var.db_name
  username                = var.username
  password                = var.password
  identifier              = "ke-db"
  skip_final_snapshot     = true
  db_subnet_group_name    = module.networking.db_subnet_group_name[0]
  vpc_security_groups_ids = module.networking.db_security_group
}

module "loadbalancer" {
  source        = "./loadbalancer"
  public_sg     = module.networking.public_sg
  public_subnet = module.networking.public_subnet
  port          = 80
  protocol      = "HTTP"
  vpc_id        = module.networking.vpc_id

}

module "compute" {
  source          = "./compute"
  public_sg       = module.networking.public_sg
  public_subnet   = module.networking.public_subnet
  volume_size     = 30
  public_key_path = "~/.ssh/k3key.pub"
  user_data_path  = "./userdata.tpl"
  dbname          = var.db_name
  dbuser          = var.username
  dbpass          = var.password
  db_endpoint     = module.database.db_endpoint
}
