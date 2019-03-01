defmodule Taskify.TaskRegister.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Taskify.TaskRegister.Task


  schema "tasks" do
    field :done, :boolean, default: false
    field :description, :string
    field :minutes_worked, :integer
    field :title, :string
    belongs_to :user, Taskify.Register.User

    timestamps()
  end

  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:title, :description, :done, :minutes_worked, :user_id])
    |> validate_required([:title, :description, :done, :user_id])
    |> validate_time(:minutes_worked)
  end

  def validate_time(changeset, field, options \\ []) do
    validate_change(changeset, field, fn _, time ->
      case rem(time, 15) == 0 do
        true -> []
        false -> [{field, options[:message] || "Time is measured in minutes with increments of 15"}]
      end
    end)
  end
end
