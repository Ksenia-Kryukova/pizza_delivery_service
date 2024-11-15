import os
from fastapi import FastAPI, APIRouter
from model.db import SqlDb
from service.pizza_service import PizzaService
from model.entities import OrderStatus, Base
from sqlalchemy import create_engine
from dotenv import load_dotenv


load_dotenv()

username = os.getenv("USERNAME")
password = os.getenv("PASSWORD")
host = os.getenv("HOST")
db_name = os.getenv("DB_NAME")
port = os.getenv("PORT")

app = FastAPI()


@app.get("/")
def hello_world():
    return "Hello, world"


engine = create_engine(f"postgresql://{username}:{password}@{host}:{port}/{db_name}")
db = SqlDb(engine)
Base.metadata.create_all(engine)
pizza_service = PizzaService(db)

router = APIRouter()


@router.post("/create_order")
async def create_order(user_id: str):
    return pizza_service.create_order(user_id)


@router.post("/add_user")
async def add_user(name: str, phone_number: int):
    return pizza_service.add_user(name, phone_number)


@router.post("/add_pizza")
async def add_pizza(order_id: str, pizza_id: str):
    pizza = db.find_pizza(pizza_id)
    pizza_service.add_pizza(order_id, pizza)
    return {"Пицца добавлена в заказ"}


@router.delete("/remove_pizza")
async def remove_pizza(order_id: str, pizza_id: str):
    pizza = db.find_pizza(pizza_id)
    pizza_service.remove_pizza(order_id, pizza)
    return {"Пицца удалена из заказа"}


@router.put("/update_address")
async def update_address(order_id: str, new_address: str):
    pizza_service.update_address(order_id, new_address)
    return {"Адрес успешно добавлен"}


@router.get("/calc_price")
async def calc_price(order_id: str):
    return pizza_service.calc_price(order_id)


@router.put("/on_payment_complete")
async def on_payment_complete(order_id: str):
    pizza_service.on_payment_complete(order_id)
    return {"Оплата совершена"}


@router.put("/update_order_status")
async def update_order_status(order_id: str, status: int):
    order_status = OrderStatus(status)
    pizza_service.update_order_status(order_id, order_status)
    return {"Статус заказа обновлен"}


app.include_router(router)
