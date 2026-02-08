resource "yandex_alb_target_group" "target-group-web" {
  name           = "web-servers"

  target {
    subnet_id    = yandex_vpc_subnet.cw_a.id
    ip_address   = yandex_compute_instance.web_a.network_interface.0.ip_address
  }

  target {
    subnet_id    = yandex_vpc_subnet.cw_b.id
    ip_address   = yandex_compute_instance.web_b.network_interface.0.ip_address
  }

}

resource "yandex_alb_backend_group" "backend-group-web" {
  name                     = "web-servers"
  http_backend {
    name                   = "web-servers"
    weight                 = 1
    port                   = 80
    target_group_ids       = [yandex_alb_target_group.target-group-web.id]
    load_balancing_config {
      panic_threshold      = 50
    }
    healthcheck {
      timeout              = "1s"
      interval             = "2s"
      healthy_threshold    = 2
      unhealthy_threshold  = 5
      healthcheck_port     = 80
      http_healthcheck {
        path              = "/"
      }
    }
  }
}

resource "yandex_alb_http_router" "cw-router" {
  name = "cw-router"
}

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


resource "yandex_alb_load_balancer" "cw-lb" {
  name = "cw-lb"

  network_id = yandex_vpc_network.cw.id
  allocation_policy {
    location {
      zone_id   = "ru-central1-a"
      subnet_id = yandex_vpc_subnet.cw_a.id
    }
    location {
      zone_id   = "ru-central1-b"
      subnet_id = yandex_vpc_subnet.cw_b.id
    }
  }

  listener {
    name = "cw-listener"
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [80]
    }
    http {
      handler {
        http_router_id = yandex_alb_http_router.cw-router.id
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
