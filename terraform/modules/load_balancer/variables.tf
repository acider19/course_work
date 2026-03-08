variable "network_id" {
  type = string
}

variable "subnet_a_id" {
  type = string
}

variable "subnet_b_id" {
  type = string
}

variable "cert_id" {
  type = string
}

variable "web_server_ips" {
  type = list(object({
    subnet_id  = string
    ip_address = string
  }))
}
