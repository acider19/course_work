resource "null_resource" "update_noip" {
  # Следим за IP балансировщика. Если он изменится — триггер сработает.
  triggers = {
    alb_ip = yandex_alb_load_balancer.cw-lb.listener[0].endpoint[0].address[0].external_ipv4_address[0].address
  }

  provisioner "local-exec" {
    # Отправляем запрос в No-IP с новым IP балансировщика
    command = "curl -s -u '${var.noip_user}:${var.noip_pass}' 'https://dynupdate.no-ip.com/nic/update?hostname={var.noip_host}&myip=${self.triggers.alb_ip}'"
  }
}

# Чтобы сразу видеть результат в консоли после apply
# output "noip_status" {
#   value = "Domain ${var.noip_host} updated to ${yandex_alb_load_balancer.cw-lb.listener[0].endpoint[0].address[0].external_ipv4_address[0].address}"
# }