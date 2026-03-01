# Структура проекта в части реализуемой с помощью Ansible

Файлы плейбуков, необходимые для установки, развертывания и конфигурирования сервисов с помощью Ansible, находтся в соответствующей [директории](../ansible/)

---

Файлы и директории выложенные в публичный (удаленный) репозиторий:

- файл [site.yaml](../ansible/site.yaml) являющийся мастер-плейбуком, содержащим последовательность запуска файлов с плейбуками для отдельных сервисов, также содержит теги, предполагающие возможность гибкого запуска конкретных плейбуков
- файл [es.yaml](../ansible/es.yaml)
- файл [exporters.yaml](../ansible/exporters.yaml)
- файл [filebeat_all.yaml](../ansible/filebeat_all.yaml)
- файл [filebeat.yaml](../ansible/filebeat.yaml)
- файл [grafana-full.yaml](../ansible/grafana-full.yaml)
- файл [kibana.yaml](../ansible/kibana.yaml)
- файл [nginx.yaml](../ansible/nginx.yaml)
- файл [prom.yaml](../ansible/prom.yaml)
- файл [snapshot.yaml](../ansible/snapshot.yaml)