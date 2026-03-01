# создание кластера PostreSQL в Managed Service for PostgreSQL
resource "yandex_mdb_postgresql_cluster" "cw-pg" {
  name        = "prom-storage"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.cw.id

  config {
    version = 15
    resources {
      resource_preset_id = "s2.micro"
      disk_type_id       = "network-ssd"
      disk_size          = 20
    }
  }

  host {
    zone      = "ru-central1-a"
    subnet_id = yandex_vpc_subnet.cw_a.id
  }

  host {
    zone      = "ru-central1-b"
    subnet_id = yandex_vpc_subnet.cw_b.id
  }
}

# создание самой базы данных
resource "yandex_mdb_postgresql_database" "prometheus_db" {
  cluster_id = yandex_mdb_postgresql_cluster.cw-pg.id
  name       = "prometheus"      # имя для переменной db_name для Ansible
  owner      = yandex_mdb_postgresql_user.admin.name
}

# создание пользователя admin для кластера PostreSQL
resource "yandex_mdb_postgresql_user" "admin" {
  cluster_id = yandex_mdb_postgresql_cluster.cw-pg.id
  name       = var.pg_user
  password   = var.pg_password
}

# ресурс, который создает файл для Ansible
resource "local_file" "ansible_vars" {
  filename = "${path.module}/ansible_vars.yaml"
  content  = <<-EOT
# Сгенерировано Terraform. Не править вручную!
db_host: "${yandex_mdb_postgresql_cluster.cw-pg.host[0].fqdn}"
db_name: "${yandex_mdb_postgresql_database.prometheus_db.name}"
db_user: "${var.pg_user}"
db_password: "${var.pg_password}"
EOT
}