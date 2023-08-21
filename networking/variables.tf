# networking variables

# vpc cidr variable
variable "vpc_cidr" {
  type        = string
  default     = ""
  description = "Vpc cidr block"
}

# public cidr
variable "public_cidr" {
  type        = list(any)
  description = "public cidr"
}

# private cidr
variable "private_cidr" {
  type        = list(any)
  description = "private cidr"
}

# access ip
variable "access_ip" {
  type        = string
  description = "description"
}

# security group
variable "security_groups" {}
