defmodule Grimoire.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Grimoire.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        avatar: "some avatar",
        email: "some email",
        name: "some name"
      })
      |> Grimoire.Accounts.create_user()

    user
  end
end
