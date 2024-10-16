from enum import Enum
from typing import List


class OrderStatus(Enum):
    NEW = 1
    ORDERED = 2
    PREPARING = 3
    READY = 4
    DELIVERING = 5
    DELIVERED = 6
    COMPLETED = 7


class User:
    """Класс для хранения информации о заказчике"""
    def __init__(self, user_id: str, name: str, phone_number: int):
        self.user_id = user_id
        self.name = name
        self.phone_number = phone_number


class Order:
    """Класс для хранения информации о заказе"""
    def __init__(self, order_id: str, user_id: str, pizzas: List['Pizza'], address: str):
        self.order_id = order_id
        self.user_id = user_id
        self.pizzas = pizzas
        self.address = address
        self.order_status = OrderStatus.NEW
        self.paid = False


class BasePizza:
    """Представляет основную пиццу из меню с её свойствами"""
    def __init__(self, base_pizza_id: str, name: str, description: str, price_rub: float):
        self.base_pizza_id = base_pizza_id
        self.name = name
        self.description = description
        self.price_rub = price_rub


class Pizza:
    """Представляет пиццу для заказа (основная пицца из меню + дополнительные ингредиенты)"""
    def __init__(self, pizza_id: str, base_pizza_id: str, topping_ids: List[str]):
        self.pizza_id = pizza_id
        self.base_pizza_id = base_pizza_id
        self.topping_ids = topping_ids


class Topping:
    """Класс для работы с дополнительными ингредиентами к пицце"""
    def __init__(self, topping_id: str, name: str, description: str, price_rub: float):
        self.topping_id = topping_id
        self.name = name
        self.description = description
        self.price_rub = price_rub
