# переменные к домашнему заданию 7-03 "Подъём инфраструктуры в Yandex Cloud"
variable "flow" {
  type    = string
  default = "41"
}
variable "cloud_id" {
  type    = string
  default = "b1g68t7p4rjq035vq0o9"
}

variable "folder_id" {
  type    = string
  default = "b1g2ett5h4qn2kbsh6gr"
}
variable "test" {
  type = map(number)
  default = {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }
}