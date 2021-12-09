defmodule Exlivery.Users.CreateOrUpdateTest do
  use ExUnit.Case

  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.CreateOrUpdate

  setup do
    UserAgent.start_link(%{})

    {:ok, %{}}
  end

  describe "call/1" do
    test "when all params are valid, save the user" do
      params = %{
        name: "Jorge",
        address: "Ladeira do centro, 161",
        email: "jorge@ben.com",
        cpf: "7845214599",
        age: 66
      }

      response = CreateOrUpdate.call(params)

      expected_response = {:ok, "User created or updated successfully"}

      assert response == expected_response
    end

    test "when there are invalid params, returns an error" do
      params = %{
        name: "Jorge",
        address: "Ladeira do centro, 161",
        email: "jorge@ben.com",
        cpf: "7845214599",
        age: 16
      }

      response = CreateOrUpdate.call(params)

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
