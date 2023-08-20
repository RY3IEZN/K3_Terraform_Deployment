locals {
  # public_access_security_group
  security_groups = {
    public = {
      name        = "k3_public_sg"
      description = "public_access_security_group"

      ingress = {
        ssh = {
          from        = 22
          to          = 22
          protocol    = "tcp"
          cidr_blocks = [var.access_ip]
        }
        http = {
          from        = 80
          to          = 80
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
        }
      }
    }
    # rds_sg
    rds = {
      name        = "k3_rds_sg"
      description = "rds_security_group"

      ingress = {
        mysql = {
          from        = 3306
          to          = 3306
          protocol    = "tcp"
          cidr_blocks = ["10.10.0.0/16"]
        }
      }
    }
  }
}