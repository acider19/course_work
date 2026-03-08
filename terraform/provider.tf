terraform {
  required_version = ">= 0.13"
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.129.0"
    }
  }

  # заготовка под бэкенд
  # backend "s3" {
  #   endpoint = "https://storage.yandexcloud.net"
  #   bucket   = "имя-твоего-бакета"
  #   region   = "ru-central1"
  #   key      = "prod/terraform.tfstate"
  #   
  #   skip_region_validation      = true
  #   skip_credentials_validation = true
  # }
}

provider "yandex" {
  # token                    = "do not use!!!"
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  # ключ сервисного акка должен читаться из переменной окружения
  # service_account_key_file = file("~/.authorized_key.json")
}