defmodule TaskifyWeb.UserController do
  use TaskifyWeb, :controller

  alias Taskify.Register
  alias Taskify.Register.User

  def index(conn, _params) do
    users = Register.select_all_from_users()
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = Register.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Register.insert_new_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Successfully registered! You may now log in.")
        |> redirect(to: page_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Register.get_user!(id)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Register.get_user!(id)
    changeset = Register.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Register.get_user!(id)

    case Register.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Register.get_user!(id)
    {:ok, _user} = Register.drop_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: user_path(conn, :index))
  end
end
