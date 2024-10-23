from enum import Enum
from typing import List
from sqlalchemy.orm import declarative_base
from sqlalchemy import Column, String, Integer, Float, Boolean, ARRAY, ForeignKey, Enum as SqlEnum
from sqlalchemy.orm import relationship
from typing import Any


Base: Any = declarative_base()


class OrderStatus(Enum):
    NEW = 1
    ORDERED = 2
    PREPARING = 3
    READY = 4
    DELIVERING = 5
    DELIVERED = 6
    COMPLETED = 7


class User(Base):
    """Класс для хранения информации о заказчике"""
    __tablename__ = 'users'
    user_id = Column(String(40), primary_key=True)
    name = Column(String(50))
    phone_number = Column(Integer)

    def __init__(self, user_id: str, name: str, phone_number: int):
        self.user_id = user_id
        self.name = name
        self.phone_number = phone_number


class Order(Base):
    """Класс для хранения информации о заказе"""
    __tablename__ = 'orders'
    order_id = Column(String(40), primary_key=True)
    user_id = Column(String(40))
    pizzas = relationship("Pizza", secondary="order_pizza")
    address = Column(String(100))
    order_status = Column(SqlEnum(OrderStatus), default=OrderStatus.NEW)
    paid = Column(Boolean, default=False)

    def __init__(self, order_id: str, user_id: str, pizzas: List['Pizza'], address: str):
        self.order_id = order_id
        self.user_id = user_id
        self.pizzas = pizzas
        self.address = address
        self.order_status = OrderStatus.NEW
        self.paid = False


class OrderPizza(Base):
    """Вспомогательная таблица для связи заказов и пицц"""
    __tablename__ = 'order_pizza'
    order_id = Column(String(40), ForeignKey('orders.order_id'), primary_key=True)
    pizza_id = Column(String(40), ForeignKey('pizzas.pizza_id'), primary_key=True)


class BasePizza(Base):
    """Представляет основную пиццу из меню с её свойствами"""
    __tablename__ = 'base_pizzas'
    base_pizza_id = Column(String(40), primary_key=True)
    name = Column(String(50))
    description = Column(String(255))
    price_rub = Column(Float)

    def __init__(self, base_pizza_id: str, name: str, description: str, price_rub: float):
        self.base_pizza_id = base_pizza_id
        self.name = name
        self.description = description
        self.price_rub = price_rub


class Pizza(Base):
    """Представляет пиццу для заказа (основная пицца из меню + дополнительные ингредиенты)"""
    __tablename__ = 'pizzas'
    pizza_id = Column(String(40), primary_key=True)
    base_pizza_id = Column(String(40))
    topping_ids = Column(ARRAY(String(40)))

    def __init__(self, pizza_id: str, base_pizza_id: str, topping_ids: List[str]):
        self.pizza_id = pizza_id
        self.base_pizza_id = base_pizza_id
        self.topping_ids = topping_ids


class Topping(Base):
    """Класс для работы с дополнительными ингредиентами к пицце"""
    __tablename__ = 'toppings'
    topping_id = Column(String(40), primary_key=True)
    name = Column(String(50))
    description = Column(String(255))
    price_rub = Column(Float)

    def __init__(self, topping_id: str, name: str, description: str, price_rub: float):
        self.topping_id = topping_id
        self.name = name
        self.description = description
        self.price_rub = price_rub
