variable "network_id" {
  type        = string
  description = "ID сети VPC"
}

variable "subnet_a_id" {
  type        = string
  description = "ID подсети в зоне A"
}

variable "subnet_b_id" {
  type        = string
  description = "ID подсети в зоне B"
}

variable "pg_user" {
  type        = string
  description = "Имя администратора БД (из tfvars)"
}

variable "pg_password" {
  type        = string
  description = "Пароль администратора БД (из tfvars)"
  sensitive   = true
}
