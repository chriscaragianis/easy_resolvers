defmodule EasyResovlers.IntegrationTest do
  use EasyResolvers.Web.ConnCase

  @valid_house {
    _id: "a_house",
    name: "a house",
    utilities: %{
      electric: "good",
      phone: "bad",
      internet: "should be a regulated public utility"
    }
  }

  test "can retrieve houses" do
    house = House.changeset(%Org{}, @valid_house)
    Repo.insert(house)
    conn =
      build_conn()
      |> put_req_header("content-type", "application/graphql")
      |> post("/api/graphql", "{ houses { name } }")

    body = conn |> response(200) |> Poison.decode!

    assert %{"data" =>  %{"houses" => [%{"name" => "a house"}]}} = body
  end
end
