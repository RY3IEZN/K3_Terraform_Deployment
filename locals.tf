locals {
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
      }
    }
  }
}
