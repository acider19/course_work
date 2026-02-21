variable "cloud_id" {
  type    = string
  default = "b1g68t7p4rjq035vq0o9"
}

variable "folder_id" {
  type    = string
  default = "b1g2ett5h4qn2kbsh6gr"
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