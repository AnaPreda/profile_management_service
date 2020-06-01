defmodule ProfileManagementService.Application do
  use Application
  import Supervisor.Spec

  def start(_type, _args) do
    :ets.new(:my_profiles, [:bag, :public, :named_table])

    Supervisor.start_link(children(), opts())
  end
  defp children do
    [
      {Plug.Adapters.Cowboy2, scheme: :http,
        plug: ProfileManagementService.Endpoint, options: [port: 4000]},
      ProfileManagementService.Repo,
      %{
        id: ProfileManagementService.Receive,
        start: {ProfileManagementService.Receive, :start_link, []}
      }


    ]
  end

  defp opts do
    [
      strategy: :one_for_one,
      name: ProfileManagementService.Supervisor
    ]
  end

end