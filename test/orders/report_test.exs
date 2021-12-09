defmodule Exlivery.Orders.ReportTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.Report

  describe "create/1" do
    test "creates the report file" do
      OrderAgent.start_link(%{})

      :order
      |> build()
      |> OrderAgent.save()

      :order
      |> build()
      |> OrderAgent.save()

      Report.create("report_test.csv")
      response = File.read!("report_test.csv")

      expected_response =
        "12345678900,pizza,1,35.75japonesa,2,46.45,128.65\n" <>
          "12345678900,pizza,1,35.75japonesa,2,46.45,128.65\n"

      assert expected_response == response
    end
  end
end
