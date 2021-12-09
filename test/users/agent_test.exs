defmodule Exlivery.Users.AgentTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Users.Agent, as: UserAgent

  setup do
    UserAgent.start_link(%{})

    cpf_founded = "78945612300"

    :user
    |> build(cpf: cpf_founded)
    |> UserAgent.save()

    {:ok, cpf_founded: cpf_founded}
  end

  describe "save/1" do
    test "saves the user" do
      user = build(:user)

      assert UserAgent.save(user) == :ok
    end
  end

  describe "get/1" do
    test "when the user is found, returns the user", %{cpf_founded: cpf_founded} do
      response = UserAgent.get(cpf_founded)

      expected_response = {:ok, build(:user, cpf: cpf_founded)}

      assert response == expected_response
    end

    test "when the user is not found, returns an error" do
      response = UserAgent.get("00000000000")

      expected_response = {:error, "User not found"}

      assert response == expected_response
    end
  end
end
