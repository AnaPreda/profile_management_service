defmodule ProfileManagementService.Endpoint do
  import Ecto.Query
  require Logger
  use Plug.Router

  alias ProfileManagementService.Repo, as: Repo
  alias ProfileManagementService.Profile, as: Profile
  plug(:match)

  plug CORSPlug, origin: "*", credentials: true, methods: ["POST", "PUT", "DELETE", "GET", "PATCH", "OPTIONS"], headers: [ "Authorization", "Content-Type", "Accept", "Origin", "User-Agent", "DNT","Cache-Control", "X-Mx-ReqToken", "Keep-Alive", "X-Requested-With", "If-Modified-Since", "X-CSRF-Token"], expose: ['Link, X-RateLimit-Reset, X-RateLimit-Limit, X-RateLimit-Remaining, X-Request-Id']

  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Poison
  )

  plug(:dispatch)

  match _ do
    send_resp(conn, 404, "Page not found!")
  end

end
