defmodule ProfileManagementService.Profile do
  use Ecto.Schema
  import Ecto.Changeset

  alias ProfileManagementService.{Profile, Repo}

  @primary_key {:username, :string, []}
  schema "profiles" do
    field :email_address, :string
    field :first_name, :string
    field :last_name, :string

    timestamps()
  end

  @fields ~w(username email_address first_name last_name)a

  def changeset(data, params \\ %{}) do
    data
    |> cast(params, @fields)
    |> validate_required([:username, :email_address, :first_name, :last_name])
  end
  
  def create(params) do
    cs = changeset(%Profile{}, params)
    Repo.insert(cs)
  end

  def update(data, params) do
    post = changeset(data, params)
    Repo.update(post)
  end
  
end
