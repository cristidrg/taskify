defmodule Taskify.Register.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Taskify.Register.User

  schema "users" do
    field :email, :string
    field :name, :string

    timestamps()
  end

  # https://elixirforum.com/t/phoenix-form-e-mail-validation/15113/9
  def changeset(%User{} = user, attrs) do
    user |> cast(attrs, [:email, :name])
    |> validate_required([:email, :name])
    |> validate_format(:email, ~r/^[A-Za-z0-9\._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}$/)
    |> unique_constraint(:email)
  end
end
