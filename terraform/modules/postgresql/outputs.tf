output "db_fqdn" {
  description = "FQDN первого хоста БД для подключения"
  value       = yandex_mdb_postgresql_cluster.cw-pg.host[0].fqdn
}

output "db_name" {
  value = yandex_mdb_postgresql_database.prometheus_db.name
}
