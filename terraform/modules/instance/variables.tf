variable "instance_name" {
  type = string
}

variable "instance_hostname" {
  type = string
}

variable "zone" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "cpu" {
  type    = string
  default = "2"
}

variable "core_fraction" {
  type    = string
  default = "20"
}

variable "ram" {
  type    = string
  default = "1"
}

variable "disk_size" {
  type    = number
  default = 10
}

variable "image_id" {
  type    = string
  default = "fd80le7s89mqfalkmsnd" # Ubuntu 22.04
}

variable "nat" {
  type    = bool
  default = false
}

variable "security_group_ids" {
  type    = list(string)
  default = []
}

variable "username" {
  type = string
}

variable "ssh_keys" {
  type = list(string)
}