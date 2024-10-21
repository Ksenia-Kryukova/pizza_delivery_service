from .entities import User, Order, Pizza, Topping, BasePizza
from sqlalchemy.orm import Session


# Interface for db
class Db:
    def find_user(self, user_id: str) -> User:
        pass

    def find_order(self, order_id: str) -> Order:
        pass

    def find_pizza(self, pizza_id: str) -> Pizza:
        pass

    def find_topping(self, topping_id: str) -> Topping:
        pass

    def find_base_pizza(self, base_pizza_id: str) -> BasePizza:
        pass

    def add_user(self, user: User):
        pass

    def save_order(self, order: Order):
        pass

    def save_topping(self, topping: Topping):
        pass

    def save_base_pizza(self, base_pizza: BasePizza):
        pass


class InMemDb(Db):
    def __init__(self):
        self.users = dict()
        self.orders = dict()
        self.pizzas = dict()
        self.base_pizzas = dict()
        self.toppings = dict()

    def find_user(self, user_id: str) -> User:
        return self.users.get(user_id)

    def find_order(self, order_id: str) -> Order:
        return self.orders.get(order_id)

    def find_pizza(self, pizza_id: str) -> Pizza:
        return self.pizzas.get(pizza_id)

    def find_topping(self, topping_id: str) -> Topping:
        return self.toppings.get(topping_id)

    def find_base_pizza(self, base_pizza_id: str) -> BasePizza:
        return self.base_pizzas.get(base_pizza_id)

    def add_user(self, user: User):
        if user.user_id not in self.users:
            self.users[user.user_id] = user

    def save_order(self, order: Order):
        self.orders[order.order_id] = order

    def save_topping(self, topping: Topping):
        if topping.topping_id not in self.toppings:
            self.toppings[topping.topping_id] = topping

    def save_base_pizza(self, base_pizza: BasePizza):
        if base_pizza.base_pizza_id not in self.base_pizzas:
            self.base_pizzas[base_pizza.base_pizza_id] = base_pizza


class SqlDb(Db):
    def __init__(self, session: Session):
        self.session = session

    def find_user(self, user_id: str) -> User:
        return self.session.query(User).filter(User.user_id == user_id).one_or_none()

    def find_order(self, order_id: str) -> Order:
        return self.session.query(Order).filter(Order.order_id == order_id).one_or_none()

    def find_pizza(self, pizza_id: str) -> Pizza:
        return self.session.query(Pizza).filter(Pizza.pizza_id == pizza_id).one_or_none()

    def find_topping(self, topping_id: str) -> Topping:
        return self.session.query(Topping).filter(Topping.topping_id == topping_id).one_or_none()

    def find_base_pizza(self, base_pizza_id: str) -> BasePizza:
        return self.session.query(BasePizza).filter(BasePizza.base_pizza_id == base_pizza_id).one_or_none()

    def add_user(self, user: User):
        self.session.add(user)
        self.session.commit()

    def save_order(self, order: Order):
        self.session.add(order)
        self.session.commit()

    def save_topping(self, topping: Topping):
        self.session.add(topping)
        self.session.commit()

    def save_base_pizza(self, base_pizza: BasePizza):
        self.session.add(base_pizza)
        self.session.commit()
