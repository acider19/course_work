# идентификатор облака в Yandex Cloud
variable "cloud_id" {
  type      = string
  sensitive = true
}

# идентификатор каталога в облаке в Yandex Cloud
variable "folder_id" {
  type      = string
  sensitive = true
}

# набор значений для вычислительных ресурсов для "обычной" ВМ
variable "comp_res" {
  type = map(number)
  default = {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }
}

# набор значений для вычислительных ресурсов для "усиленной" ВМ
variable "comp_res_ext" {
  type = map(number)
  default = {
    cores         = 2
    memory        = 4
    core_fraction = 20
  }
}

# пользователь в сервисе NoIp для обновления информации DDNS
variable "noip_user" {
  type      = string
  sensitive = true
}

# пароль в сервисе NoIp для обновления информации DDNS
variable "noip_pass" {
  type      = string
  sensitive = true
}

# домен, зарегистрированный в сервисе NoIp
variable "noip_host" {
  type = string
}

# пользователь для доступа к Managed Service for PostgreSQL
variable "pg_user" {
  type      = string
  sensitive = true
}

# пароль для доступа к Managed Service for PostgreSQL
variable "pg_password" {
  type      = string
  sensitive = true
}

# ssh пользователь ВМ
variable "vm_username" {
  type    = string
  default = "student"
}

# публичные ключи для ssh доступа к ВМ
variable "vm_ssh_keys" {
  type = list(string)
}