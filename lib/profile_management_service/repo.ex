defmodule ProfileManagementService.Repo do
  use Ecto.Repo,
    otp_app: :profile_management_service,
    adapter: Ecto.Adapters.Postgres
end
