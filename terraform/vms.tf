
#считываем данные об образе ОС
data "yandex_compute_image" "ubuntu_2204_lts" {
  family = "ubuntu-2204-lts"
}

# ВМ BASTION JUMPSERVER
resource "yandex_compute_instance" "bastion" {
  name        = "bastion" #Имя ВМ в облачной консоли
  hostname    = "bastion" #формирует FDQN имя хоста, без hostname будет сгенрировано случаное имя.
  platform_id = "standard-v3"
  zone        = "ru-central1-a" #зона ВМ должна совпадать с зоной subnet!!!

  resources {
    cores         = var.comp_res.cores
    memory        = var.comp_res.memory
    core_fraction = var.comp_res.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_2204_lts.image_id
      type     = "network-hdd"
      size     = 10
    }
  }

  metadata = {
    user-data          = file("./cloud-init.yaml")
    serial-port-enable = 1
  }

  scheduling_policy { preemptible = true }

  network_interface {
    subnet_id          = yandex_vpc_subnet.cw_a.id #зона ВМ должна совпадать с зоной subnet!!!
    nat                = true
    security_group_ids = [yandex_vpc_security_group.LAN.id, yandex_vpc_security_group.bastion_sg.id]
  }
}

# ВМ WEBSERVER A
resource "yandex_compute_instance" "web_a" {
  name        = "web-a" #Имя ВМ в облачной консоли
  hostname    = "web-a" #формирует FDQN имя хоста, без hostname будет сгенрировано случаное имя.
  platform_id = "standard-v3"
  zone        = "ru-central1-a" #зона ВМ должна совпадать с зоной subnet!!!


  resources {
    cores         = var.comp_res.cores
    memory        = var.comp_res.memory
    core_fraction = var.comp_res.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_2204_lts.image_id
      type     = "network-hdd"
      size     = 10
    }
  }

  metadata = {
    user-data          = file("./cloud-init.yaml")
    serial-port-enable = 1
  }

  scheduling_policy { preemptible = true }

  network_interface {
    subnet_id          = yandex_vpc_subnet.cw_a.id
    nat                = false
    security_group_ids = [yandex_vpc_security_group.LAN.id, yandex_vpc_security_group.web_sg.id]
  }
}

# ВМ WEBSERVER B
resource "yandex_compute_instance" "web_b" {
  name        = "web-b" #Имя ВМ в облачной консоли
  hostname    = "web-b" #формирует FDQN имя хоста, без hostname будет сгенрировано случаное имя.
  platform_id = "standard-v3"
  zone        = "ru-central1-b" #зона ВМ должна совпадать с зоной subnet!!!

  resources {
    cores         = var.comp_res.cores
    memory        = var.comp_res.memory
    core_fraction = var.comp_res.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_2204_lts.image_id
      type     = "network-hdd"
      size     = 10
    }
  }

  metadata = {
    user-data          = file("./cloud-init.yaml")
    serial-port-enable = 1
  }

  scheduling_policy { preemptible = true }

  network_interface {
    subnet_id          = yandex_vpc_subnet.cw_b.id
    nat                = false
    security_group_ids = [yandex_vpc_security_group.LAN.id, yandex_vpc_security_group.web_sg.id]

  }
}

# ВМ PROMETEUS
resource "yandex_compute_instance" "prometheus" {
  name        = "prometheus" #Имя ВМ в облачной консоли
  hostname    = "prometheus"
  platform_id = "standard-v3"
  zone        = "ru-central1-b" #зона ВМ должна совпадать с зоной subnet!!!

  resources {
    cores         = var.comp_res.cores
    memory        = var.comp_res.memory
    core_fraction = var.comp_res.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_2204_lts.image_id
      type     = "network-hdd"
      size     = 10
    }
  }

  metadata = {
    user-data          = file("./cloud-init.yaml")
    serial-port-enable = 1
  }

  scheduling_policy { preemptible = true }

  network_interface {
    subnet_id          = yandex_vpc_subnet.cw_b.id
    nat                = false
    security_group_ids = [yandex_vpc_security_group.LAN.id]

  }
}

# ВМ GRAFANA
resource "yandex_compute_instance" "grafana" {
  name        = "grafana" #Имя ВМ в облачной консоли
  hostname    = "grafana"
  platform_id = "standard-v3"
  zone        = "ru-central1-b" #зона ВМ должна совпадать с зоной subnet!!!

  resources {
    cores         = var.comp_res_ext.cores
    memory        = var.comp_res_ext.memory
    core_fraction = var.comp_res_ext.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_2204_lts.image_id
      type     = "network-hdd"
      size     = 10
    }
  }

  metadata = {
    user-data          = file("./cloud-init.yaml")
    serial-port-enable = 1
  }

  scheduling_policy { preemptible = true }

  network_interface {
    subnet_id          = yandex_vpc_subnet.cw_b.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.LAN.id, yandex_vpc_security_group.grafana_sg.id]

  }
}

# ВМ KIBANA
resource "yandex_compute_instance" "kibana" {
  name        = "kibana" #Имя ВМ в облачной консоли
  hostname    = "kibana"
  platform_id = "standard-v3"
  zone        = "ru-central1-b" #зона ВМ должна совпадать с зоной subnet!!!

  resources {
    cores         = var.comp_res_ext.cores
    memory        = var.comp_res_ext.memory
    core_fraction = var.comp_res_ext.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_2204_lts.image_id
      type     = "network-hdd"
      size     = 10
    }
  }

  metadata = {
    user-data          = file("./cloud-init.yaml")
    serial-port-enable = 1
  }

  scheduling_policy { preemptible = true }

  network_interface {
    subnet_id          = yandex_vpc_subnet.cw_b.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.LAN.id, yandex_vpc_security_group.kibana_sg.id]

  }
}

# ВМ ELASTICSEARCH
resource "yandex_compute_instance" "elasticsearch" {
  name        = "elasticsearch" #Имя ВМ в облачной консоли
  hostname    = "elasticsearch"
  platform_id = "standard-v3"
  zone        = "ru-central1-b" #зона ВМ должна совпадать с зоной subnet!!!

  resources {
    cores         = var.comp_res_ext.cores
    memory        = var.comp_res_ext.memory
    core_fraction = var.comp_res_ext.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_2204_lts.image_id
      type     = "network-hdd"
      size     = 10
    }
  }

  metadata = {
    user-data          = file("./cloud-init.yaml")
    serial-port-enable = 1
  }

  scheduling_policy { preemptible = true }

  network_interface {
    subnet_id          = yandex_vpc_subnet.cw_b.id
    nat                = false
    security_group_ids = [yandex_vpc_security_group.LAN.id]

  }
}

# место для доп виртуалок

resource "local_file" "inventory" {
  content  = <<-XYZ
  [bastion]
  bastion_host ansible_host=${yandex_compute_instance.bastion.network_interface.0.nat_ip_address}

  [webservers]
  web-a ansible_host=${yandex_compute_instance.web_a.network_interface.0.ip_address}
  web-b ansible_host=${yandex_compute_instance.web_b.network_interface.0.ip_address}

  [prometheus]
  prometheus_server ansible_host=${yandex_compute_instance.prometheus.network_interface.0.ip_address}

  [grafana]
  grafana_server ansible_host=${yandex_compute_instance.grafana.network_interface.0.ip_address}

  [elasticsearch]
  elasticsearch_server ansible_host=${yandex_compute_instance.elasticsearch.network_interface.0.ip_address}

  [kibana]
  kibana_server ansible_host=${yandex_compute_instance.kibana.network_interface.0.ip_address} external_ip=${yandex_compute_instance.kibana.network_interface.0.nat_ip_address}

  [all:vars]
  ansible_user=student
  ansible_ssh_common_args='-o ProxyCommand="ssh -p 22 -W %h:%p -q student@${yandex_compute_instance.bastion.network_interface.0.nat_ip_address}"'
  XYZ
  filename = "./hosts.ini"
}
