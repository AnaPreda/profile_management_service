use Mix.Config

config :profile_management_service, ProfileManagementService.Repo,
       database: "profiles",
       username: "postgres",
       password: "1234",
       hostname: "localhost",
       show_sensitive_data_on_connection_error: true,
       pool_size: 10

config :profile_management_service,
       ProfileManagementService.Endpoint,
       http: [
         port: 4000
       ],
       debug_errors: true,
       code_reloader: true,
       check_origin: false,
       watchers: []

config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime

config :cors_plug,
       send_preflight_response?: true