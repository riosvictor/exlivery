defmodule Exlivery.Factory do
  use ExMachina

  alias Exlivery.Orders.{Item, Order}
  alias Exlivery.Users.User

  def user_factory do
    %User{
      name: "Joseph",
      email: "joseph@banana.com",
      cpf: "12345678900",
      age: 32,
      address: "Rua superior, 150"
    }
  end

  def item_factory do
    %Item{
      category: :pizza,
      description: "Pizza de peperoni",
      quantity: 1,
      unity_price: Decimal.new("35.75")
    }
  end

  def order_factory do
    %Order{
      delivery_address: "Rua superior, 150",
      items: [
        build(:item),
        build(:item,
          description: "Temaki de atum",
          category: :japonesa,
          quantity: 2,
          unity_price: Decimal.new("46.45")
        )
      ],
      total_price: Decimal.new("128.65"),
      user_cpf: "12345678900"
    }
  end
end
