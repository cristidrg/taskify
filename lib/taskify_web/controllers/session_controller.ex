defmodule TaskifyWeb.SessionController do
  use TaskifyWeb, :controller

  alias Taskify.Register
  alias Taskify.Register.User

  def create(conn, %{"email" => email}) do
    user = Register.select_user_with_id_by_email(email)
    if user do
      conn
      |> put_session(:user_id, user.id)
      |> put_flash(:info, "#{user.name} is logged in")
      |> redirect(to: task_path(conn, :index))
    else
      conn
      |> put_flash(:error, "Creditentials not valid")
      |> redirect(to: page_path(conn, :index))
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:user_id)
    |> put_flash(:info, "Logged out.")
    |> redirect(to: page_path(conn, :index))
  end
end
