# создание кластера PostreSQL в Managed Service for PostgreSQL
resource "yandex_mdb_postgresql_cluster" "cw-pg" {
  name        = "prom-storage"
  environment = "PRESTABLE"
  network_id  = var.network_id

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
    subnet_id = var.subnet_a_id
  }

  host {
    zone      = "ru-central1-b"
    subnet_id = var.subnet_b_id
  }
}

# создание самой базы данных
resource "yandex_mdb_postgresql_database" "prometheus_db" {
  cluster_id = yandex_mdb_postgresql_cluster.cw-pg.id
  name       = "prometheus" # имя для переменной db_name для Ansible
  owner      = yandex_mdb_postgresql_user.admin.name
}

# создание пользователя admin для кластера PostreSQL
resource "yandex_mdb_postgresql_user" "admin" {
  cluster_id = yandex_mdb_postgresql_cluster.cw-pg.id
  name       = var.pg_user
  password   = var.pg_password
}
