from .entities import User, Order, Pizza, Topping, BasePizza


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
        user = self.users.get(user_id, "Такого пользователя не существует")
        return user

    def find_order(self, order_id: str) -> Order:
        order = self.orders.get(order_id, "Такого заказа не существует")
        return order

    def find_pizza(self, pizza_id: str) -> Pizza:
        pizza = self.pizzas.get(pizza_id, "Такой пиццы не существует")
        return pizza

    def find_topping(self, topping_id: str) -> Topping:
        topping = self.toppings.get(topping_id, "Такого топпинга не существует")
        return topping

    def find_base_pizza(self, base_pizza_id: str) -> BasePizza:
        base_pizza = self.base_pizzas.get(base_pizza_id, "Такой пиццы не существует")
        return base_pizza

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
