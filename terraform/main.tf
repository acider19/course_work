module "vpc" {
  source = "./modules/vpc"
}

module "bastion" {
  source             = "./modules/instance"
  instance_name      = "bastion"
  instance_hostname  = "bastion"
  zone               = "ru-central1-a"
  subnet_id          = module.vpc.subnet_ids["a"]
  nat                = true
  security_group_ids = [module.vpc.security_group_ids["bastion"]]
  ssh_keys           = var.vm_ssh_keys
  username           = var.vm_username
}

module "web_a" {
  source             = "./modules/instance"
  instance_name      = "web-a"
  instance_hostname  = "web-a"
  zone               = "ru-central1-a"
  subnet_id          = module.vpc.subnet_ids["a"]
  security_group_ids = [module.vpc.security_group_ids["web"], module.vpc.security_group_ids["lan"]]
  ssh_keys           = var.vm_ssh_keys
  username           = var.vm_username
}

module "web_b" {
  source             = "./modules/instance"
  instance_name      = "web-b"
  instance_hostname  = "web-b"
  zone               = "ru-central1-b"
  subnet_id          = module.vpc.subnet_ids["b"]
  security_group_ids = [module.vpc.security_group_ids["web"], module.vpc.security_group_ids["lan"]]
  ssh_keys           = var.vm_ssh_keys
  username           = var.vm_username
}

module "prometheus" {
  source             = "./modules/instance"
  instance_name      = "prometheus"
  instance_hostname  = "prometheus"
  zone               = "ru-central1-b"
  subnet_id          = module.vpc.subnet_ids["b"]
  security_group_ids = [module.vpc.security_group_ids["lan"]]
  ssh_keys           = var.vm_ssh_keys
  username           = var.vm_username
}

module "grafana" {
  source             = "./modules/instance"
  cpu                = "2"
  ram                = "4"
  instance_name      = "grafana"
  instance_hostname  = "grafana"
  zone               = "ru-central1-a"
  subnet_id          = module.vpc.subnet_ids["a"]
  nat                = true
  security_group_ids = [module.vpc.security_group_ids["grafana"], module.vpc.security_group_ids["lan"]]
  ssh_keys           = var.vm_ssh_keys
  username           = var.vm_username
}

module "kibana" {
  source             = "./modules/instance"
  cpu                = "2"
  ram                = "4"
  instance_name      = "kibana"
  instance_hostname  = "kibana"
  zone               = "ru-central1-a"
  subnet_id          = module.vpc.subnet_ids["a"]
  nat                = true
  security_group_ids = [module.vpc.security_group_ids["kibana"], module.vpc.security_group_ids["lan"]]
  ssh_keys           = var.vm_ssh_keys
  username           = var.vm_username
}

module "elasticsearch" {
  source             = "./modules/instance"
  cpu                = "2"
  ram                = "4"
  instance_name      = "elasticsearch"
  instance_hostname  = "elasticsearch"
  zone               = "ru-central1-b"
  subnet_id          = module.vpc.subnet_ids["b"]
  nat                = true
  security_group_ids = [module.vpc.security_group_ids["lan"]]
  ssh_keys           = var.vm_ssh_keys
  username           = var.vm_username
}

module "postgresql" {
  source      = "./modules/postgresql"
  network_id  = module.vpc.network_id
  subnet_a_id = module.vpc.subnet_ids["a"]
  subnet_b_id = module.vpc.subnet_ids["b"]
  pg_user     = var.pg_user
  pg_password = var.pg_password
}


# создание inventory (hosts.ini) для ansible
resource "local_file" "inventory" {
  filename = "${path.module}/../ansible/hosts.ini"
  content = templatefile("${path.module}/inventory.tftpl", {
    # Передаем все нужные данные в шаблон
    username      = var.vm_username
    bastion_ip    = module.bastion.external_ip
    prometheus_ip = module.prometheus.internal_ip
    grafana_ip    = module.grafana.internal_ip
    elastic_ip    = module.elasticsearch.internal_ip
    kibana_ip     = module.kibana.internal_ip
    kibana_nat_ip = module.kibana.external_ip

    # Для веб-серверов передаем карту (map)
    web_servers = {
      "web-a" = module.web_a.internal_ip
      "web-b" = module.web_b.internal_ip
    }
  })
}

# создание файла с данными для подключения к БД
resource "local_file" "db_vars" {
  # Путь относительно папки terraform в папку ansible
  filename = "${path.module}/../ansible/group_vars/all/db_vars.yml"
  content = templatefile("${path.module}/db_vars.tftpl", {
    db_host     = module.postgresql.db_fqdn
    db_name     = module.postgresql.db_name
    db_user     = var.pg_user
    db_password = var.pg_password
  })
}
