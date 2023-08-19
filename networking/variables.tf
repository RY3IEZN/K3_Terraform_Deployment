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
  default     = ""
  description = "public cidr"
}

# private cidr
variable "public_cidr" {
  type        = list(any)
  default     = ""
  description = "private cidr"
}

# access ip
variable "access_ip" {
  type        = string
  default     = ""
  description = "description"
}

# security group
variable "security_groups" {}
