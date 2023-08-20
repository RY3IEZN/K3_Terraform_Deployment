# create rds instance
resource "aws_db_instance" "default" {
  allocated_storage       = var.allocated_storage
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  db_name                 = var.db_name
  username                = var.username
  password                = var.password
  db_subnet_group_name    = var.db_subnet_group_name
  vpc_security_groups_ids = var.vpc_security_groups_ids
  identifier              = var.identifier
  skip_final_snapshot     = var.skip_final_snapshot

  tags = {
    company = "k3_mysql_db"
  }
}