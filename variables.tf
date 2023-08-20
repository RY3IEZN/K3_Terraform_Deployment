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
  default     = ""
  description = "description"
  sensitive   = true
}
variable "password" {
  type        = string
  default     = ""
  description = "description"
  sensitive   = true
}