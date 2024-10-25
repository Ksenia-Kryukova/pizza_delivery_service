from model.entities import Order, User, Pizza, OrderStatus
from model.db import Db
import uuid


class PizzaService:
    def __init__(self, db: Db):
        self.db = db

    def create_order(self, user_id: str) -> Order:
        user = self.db.find_user(user_id)
        if not user:
            raise ValueError("Пользователь не найден")

        order_id = str(uuid.uuid4())
        new_order = Order(order_id, user_id, [], "")
        self.db.save_order(new_order)
        return new_order

    def add_user(self, name: str, phone_number: int) -> User:
        user_id = str(uuid.uuid4())
        new_user = User(user_id, name, phone_number)
        self.db.add_user(new_user)
        return new_user

    def add_pizza(self, order_id: str, pizza: Pizza):
        order = self.db.find_order(order_id)
        if not order:
            raise ValueError("Заказ не найден")
        if order.order_status != OrderStatus.NEW:
            raise ValueError("Заказ нельзя изменять после подтверждения")

        order.pizzas.append(pizza)
        self.db.save_order(order)

    def remove_pizza(self, order_id: str, pizza_id: str):
        order = self.db.find_order(order_id)
        if not order:
            raise ValueError("Заказ не найден")
        if order.order_status != OrderStatus.NEW:
            raise ValueError("Заказ нельзя изменять после подтверждения")
        if pizza_id in order.pizza_ids:
            order.pizza_ids.remove(pizza_id)
            self.db.save_order(order)
        else:
            raise ValueError("Пицца не найдена в заказе")

    def update_address(self, order_id: str, new_address: str):
        order = self.db.find_order(order_id)
        if not order:
            raise ValueError("Заказ не найден")
        if order.order_status != OrderStatus.NEW:
            raise ValueError("Заказ нельзя изменять после подтверждения")

        order.address = new_address
        self.db.save_order(order)

    def calc_price(self, order_id: str) -> float:
        order = self.db.find_order(order_id)
        if not order:
            raise ValueError("Заказ не найден")

        price = 0.0
        for pizza_order in order.pizzas:
            pizza = self.db.find_pizza(pizza_order.pizza_id)
            if not pizza:
                raise ValueError(f"Пицца с id {pizza_order.pizza_id} не найдена")

            base_pizza = self.db.find_base_pizza(pizza.base_pizza_id)
            if not base_pizza:
                raise ValueError(f"Базовая пицца с id {pizza.base_pizza_id} не найдена")

            price += base_pizza.price_rub
            for topping_id in pizza.topping_ids:
                topping = self.db.find_topping(topping_id)
                if not topping:
                    raise ValueError(f"Топпинг с id {topping_id} не найден")
                price += topping.price_rub

        return price

    def on_payment_complete(self, order_id: str):
        order = self.db.find_order(order_id)
        if not order:
            raise ValueError("Заказ не найден")

        order.paid = True
        self.db.save_order(order)

    def update_order_status(self, order_id: str, status: OrderStatus):
        order = self.db.find_order(order_id)
        if not order:
            raise ValueError("Заказ не найден")

        if status in OrderStatus:
            order.order_status = status
            self.db.save_order(order)
        else:
            raise ValueError("Недопустимый статус заказа")
