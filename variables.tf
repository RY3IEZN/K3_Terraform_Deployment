# access ip
variable "access_ip" {
  type        = string
  default     = ""
  description = "description"
}

# ---db vars---
variable "db_name" {
  type        = string
  default     = "k3rancher"
  description = "description"
}
variable "username" {
  type        = string
  sensitive   = true
}
variable "password" {
  type        = string
  sensitive   = true
}