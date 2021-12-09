defmodule Exlivery.Users.UserTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Users.User

  describe "build/5" do
    test "when all params are valid, returns the user" do
      response =
        User.build(
          "Rua superior, 150",
          "Joseph",
          "joseph@banana.com",
          "12345678900",
          32
        )

      expected_response = {:ok, build(:user)}

      assert response == expected_response
    end

    test "when there are invalid params, returns an error" do
      response =
        User.build(
          "Rua de cima",
          "Jonas Jr",
          "jorge@huggo.com",
          "12345678900",
          14
        )

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
