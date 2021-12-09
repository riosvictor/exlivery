defmodule Exlivery.Orders.AgentTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.Agent, as: OrderAgent

  setup do
    OrderAgent.start_link(%{})

    order = build(:order)

    {:ok, uuid} = OrderAgent.save(order)

    {:ok, uuid_founded: uuid, order_search: order}
  end

  describe "save/1" do
    test "saves the order" do
      order = build(:order)

      assert {:ok, _uuid} = OrderAgent.save(order)
    end
  end

  describe "get/1" do
    test "when the order is found, returns the order", %{
      uuid_founded: uuid_founded,
      order_search: order_search
    } do
      response = OrderAgent.get(uuid_founded)

      expected_response = {:ok, order_search}

      assert response == expected_response
    end

    test "when the user is not found, returns an error" do
      response = OrderAgent.get("00000000000")

      expected_response = {:error, "Order not found"}

      assert response == expected_response
    end
  end

  describe "list_all/0" do
    test "when the order is found, returns the order" do
      response = Map.values(OrderAgent.list_all())

      assert is_list(response)
    end
  end
end
