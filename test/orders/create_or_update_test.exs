defmodule Exlivery.Orders.CreateOrUpdateTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.CreateOrUpdate
  alias Exlivery.Users.Agent, as: UserAgent

  setup do
    Exlivery.start_agents()

    cpf = "78945612300"

    :user
    |> build(cpf: cpf)
    |> UserAgent.save()

    item1 = %{
      category: :pizza,
      description: "Pizza de pepetoni",
      quantity: 1,
      unity_price: "35.50"
    }

    item2 = %{
      category: :pizza,
      description: "Pizza de calabresa",
      quantity: 2,
      unity_price: "31.65"
    }

    {:ok, user_cpf: cpf, item1: item1, item2: item2}
  end

  describe "call/1" do
    test "when all params are valid, save the order", %{user_cpf: cpf, item1: item1, item2: item2} do
      params = %{
        user_cpf: cpf,
        items: [item1, item2]
      }

      response = CreateOrUpdate.call(params)

      assert {:ok, _uuid} = response
    end

    test "when there is no user with given cpf, return an error", %{item1: item1, item2: item2} do
      params = %{
        user_cpf: "00000000000",
        items: [item1, item2]
      }

      response = CreateOrUpdate.call(params)

      expected_response = {:error, "User not found"}

      assert response == expected_response
    end

    test "when there are invalid items, return an error", %{
      user_cpf: cpf,
      item1: item1,
      item2: item2
    } do
      params = %{
        user_cpf: cpf,
        items: [%{item1 | quantity: 0}, item2]
      }

      response = CreateOrUpdate.call(params)

      expected_response = {:error, "Invalid items"}

      assert response == expected_response
    end

    test "when empty items, return an error", %{user_cpf: cpf} do
      params = %{
        user_cpf: cpf,
        items: []
      }

      response = CreateOrUpdate.call(params)

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
