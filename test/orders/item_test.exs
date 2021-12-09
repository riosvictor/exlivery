defmodule Exlivery.Orders.ItemTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.Item

  describe "build/4" do
    test "when all params are valid, returns the item" do
      response =
        Item.build(
          "Pizza de peperoni",
          :pizza,
          "35.75",
          1
        )

      expected_response = {:ok, build(:item)}

      assert response == expected_response
    end

    test "when there is and invalid category, returns an error" do
      response = Item.build("Pizza de peperoni", :banana, "35.75", 1)

      expected_response = {:error, "Invalid parameters!"}

      assert response == expected_response
    end

    test "when there is and invalid price, returns an error" do
      response =
        Item.build(
          "Pizza de peperoni",
          :pizza,
          "banana_price",
          1
        )

      expected_response = {:error, "Invalid price!"}

      assert response == expected_response
    end

    test "when there is and invalid quantity, returns an error" do
      response = Item.build("Pizza de peperoni", :pizza, "35.75", 0)

      expected_response = {:error, "Invalid parameters!"}

      assert response == expected_response
    end
  end
end
