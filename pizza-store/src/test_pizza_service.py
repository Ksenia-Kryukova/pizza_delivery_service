import pytest
import uuid
from service.pizza_service import PizzaService
from model.db import InMemDb, SqlDb
from model.entities import Pizza, Topping, BasePizza, OrderStatus, Base
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker


def deliver_order(pizza_service: PizzaService, order_id: str):
    assert pizza_service.db.find_order(order_id) is not None, "Заказ не найден"

    statuses = [
        OrderStatus.PREPARING,
        OrderStatus.READY,
        OrderStatus.DELIVERING,
        OrderStatus.DELIVERED
    ]
    for status in statuses:
        pizza_service.update_order_status(order_id, status)
        current_status = pizza_service.db.find_order(order_id).order_status
        assert current_status == status, f"Не удалось обновить статус заказа до {status}"

    final_status = pizza_service.db.find_order(order_id).order_status
    assert final_status == OrderStatus.DELIVERED, "Заказ не доставлен"


@pytest.fixture(scope='module')
def db_session():
    engine = create_engine("postgresql://maslova:maslova_pw@localhost/pizza_service_db")
    Session = sessionmaker(bind=engine)
    session = Session()
    yield session
    session.close()


@pytest.mark.parametrize("db_class", [InMemDb, SqlDb])
def test_pizza_sevice_happy_path(db_class, request):
    if db_class == SqlDb:
        db_session = request.getfixturevalue('db_session')
        db = SqlDb(db_session)
    else:
        db = InMemDb()

    pepperoni = BasePizza(
        str(uuid.uuid4()),
        "Pepperoni",
        "Pizza Pepperoni is the authentic Italian taste",
        650
    )
    db.save_base_pizza(pepperoni)

    pinapple = Topping(
        str(uuid.uuid4()),
        "Pineapple",
        "Delicious fresh pineaples for Hawaiian taste",
        50
    )
    db.save_topping(pinapple)

    pizza_service = PizzaService(db)
    user = pizza_service.add_user("Name", 79003002010)
    order = pizza_service.create_order(user.user_id)

    pepperoni_pinapple = Pizza(
        str(uuid.uuid4()),
        pepperoni.base_pizza_id,
        [pinapple.topping_id]
    )
    db.save_pizza(pepperoni_pinapple)

    pizza_service.add_pizza(order.order_id, pepperoni_pinapple)
    pizza_service.update_address(order.order_id, "Russia, Moscow, Krasnaya ploschad', 1")
    pizza_service.update_order_status(order.order_id, OrderStatus.ORDERED)

    deliver_order(pizza_service, order.order_id)

    price = pizza_service.calc_price(order.order_id)
    expected_price = pepperoni.price_rub + pinapple.price_rub
    assert price == expected_price, f"Неправильная цена заказа: {price}"

    pizza_service.on_payment_complete(order.order_id)
    assert pizza_service.db.find_order(order.order_id).paid, "Оплата не завершена"

    pizza_service.update_order_status(order.order_id, OrderStatus.COMPLETED)

    final_status = pizza_service.db.find_order(order.order_id).order_status
    assert final_status == OrderStatus.COMPLETED, "Заказ не завершен"
