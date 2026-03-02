# Скриншоты основных этапов развертывания отказоустойчивой инфраструктуры

1. Итог выполнения Terraform

![terraform](../img/tf_ok.png)

---

2. Выполнения Ansible

Выполнение плейбуков nginx и exporters

![ansible](../img/playbook_nginx_exporters_ok.png)


Выполнение плейбука prom

![ansible](../img/playbook_prom_ok.png)


Выполнение плейбука grafana

![ansible](../img/playbook_grafana_ok.png)


Выполнение плейбука kibana

![ansible](../img/playbook_kibana_ok.png)


Выполнение плейбука es

![ansible](../img/playbook_es_ok.png)


Выполнение плейбука filebeat_all

![ansible](../img/playbook_filebeat_ok.png)


Выполнение плейбука snapshot

![ansible](../img/playbook_snapshots_ok.png)


Итог выполнения мастер-плейбука site

![ansible](../img/all_ansible_ok.png)

---

3. Скриншот раздела Compute Cloud в личном кабинете Yandex Cloud

![yandex compute cloud](../img/yc_compute_cloud.png)


4. Скриншот раздела Virtual Private Cloud/Облачные сети в личном кабинете Yandex Cloud

![yandex vpc network](../img/yc_cw_vpc.png)


5. Скриншот раздела Virtual Private Cloud/Подсети в личном кабинете Yandex Cloud

![yandex vpc subnetworks](../img/yc_cw_vpc_subnets.png)


6. Скриншот раздела Application Load Balancer в личном кабинете Yandex Cloud

![yandex alb](../img/yc_alb.png)


7. Скриншот главной страницы сайта

![main page](../img/main_page.png)


8. Скриншот личного кабинета сервиса регистрации доменов NoIp

![noip](../img/noip.png)


9. Скриншот web-ui Grafana

![grafana](../img/grafana_ui.png)


10. Скриншот web-ui Kibana

![kibana](../img/kibana_ui.png)


11. Скриншот вывода команды `docker ps -a` на ВМ web-a

![web-a docker](../img/docker_web_a.png)


12. Скриншот вывода команды `docker ps -a` на ВМ web-b

![web-b docker](../img/docker_web_b.png)


13. Скриншот вывода команды `docker ps -a` на ВМ prometheus

![prometheus docker](../img/docker_prometheus.png)


14. Скриншот вывода команды `docker ps -a` на ВМ grafana

![grafana docker](../img/docker_grafana.png)


15. Скриншот вывода команды `docker ps -a` на ВМ elasticsearch

![elasticsearch docker](../img/docker_elasticsearch.png)


16. Скриншот вывода команды `docker ps -a` на ВМ kibana

![kibana docker](../img/docker_kibana.png)
