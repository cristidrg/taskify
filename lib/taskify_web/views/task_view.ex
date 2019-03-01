defmodule TaskifyWeb.TaskView do
  use TaskifyWeb, :view
  import Ecto.Query

  def render_users do
    Enum.map(Taskify.Register.select_all_from_users(), &{&1.name, &1.id})
  end
end
