defmodule Grimoire.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Grimoire.Repo
  alias Ueberauth.Auth

  alias Grimoire.Accounts.{User, UserFromAuth}

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Gets a single user by an %Ueberauth.Auth{}.

  ## Examples

      iex> get_user_by_auth!(%Ueberauth.Auth{uid: 123, provider: :gitub})
      %User{}

      iex> get_user_by_auth!(%Ueberauth.Auth{uid: 456, provider: :gitub})
      nil

  """
  def get_user_by_auth(%Auth{uid: uid, provider: provider}) when is_nil(uid) or is_nil(provider),
    do: nil

  def get_user_by_auth(%Auth{uid: uid, provider: provider}) do
    Repo.get_by(User, uid: "#{uid}", provider: "#{provider}")
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Update or insert a user.

  ## Examples

      iex> upsert_user!(%{field: value})
      {:ok, %User{}}

      iex> upsert_user!(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def upsert_user(%Auth{} = auth) do
    attrs = UserFromAuth.build(auth)

    case get_user_by_auth(auth) do
      nil -> User.changeset(%User{}, attrs)
      user -> User.changeset(user, attrs)
    end
    |> Repo.insert_or_update()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end
end
