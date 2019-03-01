defmodule Taskify.TaskRegister do
  import Ecto.Query, warn: false
  alias Taskify.Repo

  alias Taskify.TaskRegister.Task

  def select_all_tasks do
    Repo.all(Task)
    |> Repo.preload(:user)
  end

  def select_task_with_id!(id) do
    Repo.get!(Task, id)
    |> Repo.preload(:user)
  end

  def insert_task(attrs \\ %{}) do
    %Task{}
    |> Task.changeset(attrs)
    |> Repo.insert()
  end

  def update_task(%Task{} = task, attrs) do
    task
    |> Task.changeset(attrs)
    |> Repo.update()
  end

  def drop_task(%Task{} = task) do
    Repo.delete(task)
  end

  def change_task(%Task{} = task) do
    Task.changeset(task, %{})
  end
end
