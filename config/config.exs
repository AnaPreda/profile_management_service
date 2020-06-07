use Mix.Config

config :phoenix, :json_library, Jason

config :profile_management_service,
       app_secret_key: "secret",
       jwt_validity: 3600,
       api_host: "localhost",
       api_version: "2",
       api_prefix: "http",
       um_url: "https://myblog-um.gigalixirapp.com"
#
config :profile_management_service, ProfileManagementService.Endpoint,
       url: [host: "localhost"]
#       secret_key_base: "ASZcFFBCOp0L1T+514xPNRh/23XvyM4UWp0PE4dvFzIHMhuwCG7ABLRnwgq41e8U",
#       render_errors: [view: UserManagementWeb.ErrorView, accepts: ~w(json)],
#       pubsub: [name: UserManagement.PubSub, adapter: Phoenix.PubSub.PG2],
#       live_view: [signing_salt: "oCfVawWa"]

config :profile_management_service, ProfileManagementService.Repo,
       database: "profiles",
       username: "postgres",
       password: "1234",
       hostname: "localhost"

#config :cors_plug,
#       origin: "*",
#       methods: ["GET", "POST"]
config :cors_plug,
       send_preflight_response?: true

config :profile_management_service, ecto_repos: [ProfileManagementService.Repo]

config :plug, :validate_header_keys_during_test, true

import_config "#{Mix.env()}.exs"