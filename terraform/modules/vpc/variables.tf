variable "network_name" {
  type    = string
  default = "cw-vpc"
}

variable "subnets" {
  type = list(object({
    name = string
    zone = string
    cidr = string
  }))
  default = [
    { name = "cw-ru-central1-a", zone = "ru-central1-a", cidr = "10.0.1.0/24" },
    { name = "cw-ru-central1-b", zone = "ru-central1-b", cidr = "10.0.2.0/24" }
  ]
}
