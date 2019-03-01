defmodule Taskify.Register do
  import Ecto.Query, warn: false
  alias Taskify.Repo
  alias Taskify.Register.User

  def select_all_from_users do
    Repo.all(User)
  end

  def select_user_with_id!(id), do: Repo.get!(User, id)

  def select_user_with_id(id), do: Repo.get(User, id)

  def select_user_with_id_by_email(email) do
    Repo.get_by(User, email: email)
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def insert_new_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def drop_user(%User{} = user) do
    Repo.delete(user)
  end
  
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end
end
