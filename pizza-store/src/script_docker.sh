#!/bin/bash

# Остановка скрипта при ошибке
set -e

# Запуск тестов
echo "Запуск тестов"
export PYTHONPATH=/home/kryukova/Pizza_delivery_service/pizza-store/src
pytest -v test_pizza_service.py

# Сборка docker-образа
echo "Тесты завершены. Собираем docker-образ"
docker build -t pizza_service_image .

echo "Docker-образ собран успешно"