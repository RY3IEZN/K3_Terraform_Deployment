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
