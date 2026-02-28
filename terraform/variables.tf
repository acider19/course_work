variable "cloud_id" {
  type    = string
  sensitive = true
}

variable "folder_id" {
  type    = string
  sensitive = true
}

variable "comp_res" {
  type = map(number)
  default = {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }
}

variable "comp_res_ext" {
  type = map(number)
  default = {
    cores         = 2
    memory        = 4
    core_fraction = 20
  }
}

variable "noip_user" {
  type      = string
  sensitive = true
}

variable "noip_pass" {
  type      = string
  sensitive = true
}

variable "noip_host" {
  type      = string
}

variable "pg_user" {
  type        = string
  sensitive   = true
}

variable "pg_password" {
  type        = string
  sensitive   = true
}
