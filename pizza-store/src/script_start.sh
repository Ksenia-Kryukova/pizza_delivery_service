#!/bin/bash

# Остановка скрипта при ошибке
set -e

# Запуск тестов
echo "Запуск тестов"
export PYTHONPATH="$(dirname "$0")"
pytest -v test_pizza_service.py

# Запуск проекта
echo "Тесты завершены. Запуск проекта"
uvicorn api.pizza_service_api:app --reload

echo "Проект запущен успешно"