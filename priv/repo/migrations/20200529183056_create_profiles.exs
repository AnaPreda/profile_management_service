defmodule ProfileManagementService.Repo.Migrations.CreateProfiles do
  use Ecto.Migration

  def change do
    create table(:profiles, primary_key: false) do
      add :username, :string, primary_key: true
      add :email_address, :string, null: false
      add :last_name, :string, null: false
      add :first_name, :string, null: false

      timestamps()
    end
  end
end
