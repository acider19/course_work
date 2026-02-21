#!/bin/bash

# Останавливаем скрипт при критических ошибках
set -e

# Настройки путей
TF_DIR="./terraform"
ANSIBLE_DIR="./ansible"
INVENTORY="../terraform/hosts.ini" # Путь относительно папки ansible

echo "--- [1/3] Подготовка среды ---"
# Удаляем старые записи ssh, чтобы не было ошибки "Host key verification failed"
if [ -f "$HOME/.ssh/known_hosts" ]; then
    rm "$HOME/.ssh/known_hosts"
    echo "🧹 Файл known_hosts очищен."
fi

echo "--- [2/3] Запуск Terraform Apply (ожидание 5-7 мин) ---"
cd "$TF_DIR"
# Выполняем apply
terraform apply -auto-approve

# Проверяем код завершения последней команды
if [ $? -eq 0 ]; then
    echo "✅ Terraform успешно завершил работу."
else
    echo "❌ Ошибка в работе Terraform. Прекращаю выполнение."
    exit 1
fi

echo "⏳ Ждем 30 секунд для инициализации SSH на серверах..."
sleep 30

echo "--- [3/3] Запуск Ansible Playbook ---"
cd "../$ANSIBLE_DIR"

if [ -f "$INVENTORY" ]; then
    ansible-playbook -i "$INVENTORY" site.yaml
else
    echo "❌ Ошибка: Файл $INVENTORY не найден в $TF_DIR"
    exit 1
fi

echo "✨ Развертывание полностью завершено!"

