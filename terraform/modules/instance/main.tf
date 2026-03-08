#считываем данные об образе ОС
data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2204-lts"
}

resource "yandex_compute_instance" "this" {
  name        = var.instance_name
  hostname    = var.instance_hostname
  platform_id = "standard-v3"
  zone        = var.zone

  resources {
    cores         = var.cpu
    core_fraction = var.core_fraction
    memory        = var.ram
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      type     = "network-hdd"
      size     = var.disk_size
    }
  }

  network_interface {
    subnet_id          = var.subnet_id
    nat                = var.nat
    security_group_ids = var.security_group_ids
  }

  metadata = {
    user-data = templatefile("${path.module}/cloud-init.tftpl", {
      username = var.username
      ssh_keys = var.ssh_keys
    })
    serial-port-enable = 1
  }

  scheduling_policy {
    preemptible = true
  }
}
