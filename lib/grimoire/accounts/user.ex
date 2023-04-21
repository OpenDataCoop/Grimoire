defmodule Grimoire.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :avatar_url, :string
    field :profile_url, :string
    field :provider, :string
    field :uid, :string
    field :username, :string
    field :email, :string
    field :name, :string

    timestamps()
  end

  @required_attrs [:avatar_url, :email, :name, :provider, :uid]

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:avatar_url, :email, :name, :profile_url, :provider, :uid, :username])
    |> validate_required(@required_attrs)
    |> unique_constraint(:email)
    |> unique_constraint(:uid_provider)
  end
end
