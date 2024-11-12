#!/bin/bash

# Остановка скрипта при ошибке
set -e

# Запуск тестов
echo "Запуск тестов"
export PYTHONPATH=/home/kryukova/Pizza_delivery_service/pizza-store/src
pytest -v test_pizza_service.py

# Запуск проекта
echo "Тесты завершены. Запуск проекта"
uvicorn api.pizza_service_api:app --reload

echo "Проект запущен успешно"