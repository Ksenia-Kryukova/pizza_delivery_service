### README.md

```markdown
# Pizza Delivery Service

## Описание проекта

Pizza Delivery Service — это REST API-сервис для управления доставкой пиццы.  
Проект разработан на **FastAPI**, с поддержкой двух типов баз данных:  
- **In-Memory Database** для тестирования и демонстрации;  
- **PostgreSQL** для реального использования.  
Для работы с базой данных используется **SQLAlchemy**. 
Проект включает Bash-скрипты для запуска и тестирования, а также **Docker** для контейнеризации.
Также в проекте применены принципы **ООП**.

---

## Технологии

- **Backend**: FastAPI 
- **API Type**: REST API 
- **Database**: PostgreSQL (реальная база данных) и In-Memory Database (тестовая база данных)  
- **ORM**: SQLAlchemy 
- **Containerization**: Docker, Docker Compose  
- **Scripting**: Bash-скрипты для автоматизации запуска и тестирования
- **Environment Variables**: Python dotenv 
- **Additionally**: ООП

---

## Установка и запуск

### Локальный запуск

1. **Клонируйте репозиторий**:
   ```bash
   git clone https://github.com/Ksenia-Kryukova/pizza_delivery_service.git
   cd pizza_delivery_service
   ```

2. **Установите зависимости**:
   Рекомендуется использовать виртуальное окружение:
   ```bash
   python -m venv venv
   source venv/bin/activate   # Для Linux/MacOS
   venv\Scripts\activate      # Для Windows
   pip install -r requirements.txt
   ```

3. **Запустите проект**:
   ```bash
   bash /script_start.sh
   ```

### Запуск с использованием Docker

1. **Соберите контейнеры и запустите сервис**:
   ```bash
   docker-compose up --build
   ```

2. Приложение будет доступно по адресу:  
   [http://localhost:8000](http://localhost:8000)

---

## Тестирование

Для запуска тестов выполните команду:  
```bash
bash /script_docker.sh
```

---

## Структура проекта

```plaintext
pizza-store/
    └── src/                        
        ├── api/                       # Маршруты FastAPI
        ├── model/                     # Конфигурация и модели базы данных
        ├── service/                   # Бизнес-логика приложения
        ├── test_pizza_service.py      # Бизнес-логика приложения
        ├── script_docker.sh           # Bash-скрипт для запуска теста и сборки Docker-образа
        ├── script_start.sh            # Bash-скрипт для локального запуска теста и проекта
        ├── docker-compose.yml         # Конфигурация Docker Compose
        ├── Dockerfile                 # Конфигурация Docker
        ├── requirements.txt           # Зависимости Python
        ├── .env                       # Переменные окружения
        └── README.md                  # Документация
```

---

## Маршруты API

| Метод | Путь                  | Описание                        |
|-------|-----------------------|---------------------------------|
| POST  | `/create_order`       | Создание нового заказа          |
| POST  | `/add_user`           | Создание нового пользователя    |
| POST  | `/add_pizza`          | Добавление пиццы в заказ        |
| PUT   | `/update_address`     | Обновление адреса заказа        |
| DELETE| `/remove_pizza`       | Удаление пиццы из заказа        |
| GET   | `/calc_price`         | Получение стоимости пиццы       |
| PUT   | `/on_payment_complete`| Обновление статуса оплаты       |
| PUT   | `/update_order_status`| Обновление статуса заказа       |

---

## Переменные окружения

Файл `.env` содержит основные настройки:

```env
USERNAME=your_user_name
PASSWORD=your_password
DB_NAME=pizza_service_db
HOST=localhost
PORT=5432
SERVER_PORT=8000
```

---

## Контейнеризация

- **Dockerfile**: содержит инструкции для создания образа приложения.
- **docker-compose.yml**: описывает контейнеры для приложения и базы данных.

---

## Особенности

1. **Две базы данных**:
   - In-Memory Database (для тестов)
   - PostgreSQL (основная база данных)

2. **Скрипты автоматизации**:
   - `script_start.sh`: для локального запуска теста и проекта.
   - `script_docker.sh`: для запуска теста и сборки Docker-образа.

3. **Полностью контейнеризованный проект**:  
   Возможность запуска без установки зависимостей локально.

---

## Контакты

Автор: Ксения Маслова
Email: ksyusha-kryukova@bk.ru
GitHub: github.com/Ksenia-Kryukova

```