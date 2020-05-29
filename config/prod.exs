use Mix.Config

config :profile_management_service, ProfileManagementService.Repo,
       adapter: Ecto.Adapters.Postgres,
         #       url: "ecto://76a65d2b-cc73-4eee-8efa-cfe3081763b9-user:pw-ddc89d6e-8eff-4387-a061-037f6224ae11@postgres-free-tier-1.gigalixir.com:5432/76a65d2b-cc73-4eee-8
         #efa-cfe3081763b9",
       url: System.get_env("DATABASE_URL"),
       pool_size: 2,
       ssl: true

config :profile_management_service, ProfileManagementService.Endpoint,
       http: [port: {:system, "PORT"}], # Possibly not needed, but doesn't hurt
       url: [host: System.get_env("APP_NAME") <> ".gigalixirapp.com", port: 80],
       secret_key_base: Map.fetch!(System.get_env(), "SECRET_KEY_BASE"),
       server: true

config :cors_plug,
       send_preflight_response?: true


