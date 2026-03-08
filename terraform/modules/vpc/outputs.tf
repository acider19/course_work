output "network_id" {
  value = yandex_vpc_network.cw.id
}

output "subnet_ids" {
  value = {
    "a" = yandex_vpc_subnet.cw_a.id
    "b" = yandex_vpc_subnet.cw_b.id
  }
}

output "security_group_ids" {
  value = {
    bastion = yandex_vpc_security_group.bastion_sg.id
    lan     = yandex_vpc_security_group.LAN.id
    web     = yandex_vpc_security_group.web_sg.id
    grafana = yandex_vpc_security_group.grafana_sg.id
    kibana  = yandex_vpc_security_group.kibana_sg.id
  }
}
