resource "yandex_alb_target_group" "target-group-web" {
  name = "web-servers"

  dynamic "target" {
    for_each = var.web_server_ips
    content {
      subnet_id  = target.value.subnet_id
      ip_address = target.value.ip_address
    }
  }
}

# создание бэкэнд группы определяющей, что трафик пойдет на 80 порт вебсерверов из соответствующей таргет группы
resource "yandex_alb_backend_group" "backend-group-web" {
  name = "web-servers"
  http_backend {
    name             = "web-servers"
    weight           = 1
    port             = 80
    target_group_ids = [yandex_alb_target_group.target-group-web.id]
    load_balancing_config {
      panic_threshold = 50
    }
    healthcheck {
      timeout             = "1s"
      interval            = "2s"
      healthy_threshold   = 2
      unhealthy_threshold = 5
      healthcheck_port    = 80
      http_healthcheck {
        path = "/"
      }
    }
  }
}

# http роутер
resource "yandex_alb_http_router" "cw-router" {
  name = "cw-router"
}

# аналог блока server в Nginx или виртуального хоста в Apache
resource "yandex_alb_virtual_host" "cw-vhost" {
  name           = "cw-virtual-host"
  http_router_id = yandex_alb_http_router.cw-router.id
  route {
    name = "cw-route"
    http_route {
      http_match {
        path {
          prefix = "/"
        }
      }
      http_route_action {
        backend_group_id = yandex_alb_backend_group.backend-group-web.id
        timeout          = "60s"
      }
    }
  }
}

# точка входа для приема внешнего трафика, принимает http и https, при этом расшифровывая его, отправляет на http-роутер
resource "yandex_alb_load_balancer" "cw-lb" {
  name = "cw-lb"

  network_id = var.network_id
  allocation_policy {
    location {
      zone_id   = "ru-central1-a"
      subnet_id = var.subnet_a_id
    }
    location {
      zone_id   = "ru-central1-b"
      subnet_id = var.subnet_b_id
    }
  }

  # слушатель для редиректа (HTTP -> HTTPS)
  listener {
    name = "http-listener"
    endpoint {
      address {
        external_ipv4_address {}
      }
      ports = [80]
    }
    http {
      handler {
        http_router_id = yandex_alb_http_router.cw-router.id # Тот же роутер
      }
    }
  }

  # слушатель для HTTPS (СЕРТИФИКАТ)
  listener {
    name = "https-listener"
    endpoint {
      address {
        external_ipv4_address {}
      }
      ports = [443]
    }
    tls {
      default_handler {
        http_handler {
          http_router_id = yandex_alb_http_router.cw-router.id
        }
        certificate_ids = [var.cert_id]
      }
    }
  }

  log_options {
    discard_rule {
      http_code_intervals = ["HTTP_2XX"]
      discard_percent     = 75
    }
  }
}
