defmodule ProfileManagementService.Router do
  use Plug.Router
  import Ecto.Query

  require Logger
  plug(Plug.Logger, log: :debug)
  alias ProfileManagementService.Repo, as: Repo
  alias ProfileManagementService.Profile, as: Profile
  alias ProfileManagementService.ProfileUtils, as: Utils
  plug(:match)

  plug CORSPlug, origin: "*", credentials: true, methods: ["POST", "PUT", "DELETE", "GET", "PATCH", "OPTIONS"], headers: [ "Authorization", "Content-Type", "Accept", "Origin", "User-Agent", "DNT","Cache-Control", "X-Mx-ReqToken", "Keep-Alive", "X-Requested-With", "If-Modified-Since", "X-CSRF-Token"], expose: ['Link, X-RateLimit-Reset, X-RateLimit-Limit, X-RateLimit-Remaining, X-Request-Id']

  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Poison
  )

  plug(:dispatch)

  get"/get_profile_by_username" do
    username = Map.get(conn.params, "username", nil)
    token = List.last(String.split(List.first(get_req_header(conn, "authorization"))))

    case Utils.is_valid_token(token) do
      true ->
        profile =  Repo.get(Profile, username)
        case is_nil(profile) do
          true ->
            conn
            |> put_resp_content_type("application/json")
            |> send_resp(404, Poison.encode!(%{"error" => "Profile not found with this username"}))
          false ->
            conn
            |>put_resp_content_type("application/json")
            |>send_resp(200,Poison.encode!(%{:profile=>profile}))
        end
      false ->
        conn
        |>put_resp_content_type("application/json")
        |>send_resp(401,Poison.encode!(%{:error=>"Unauthorized"}))
    end
  end

  put "/update_profile" do
    {username, email_address, first_name, last_name} = {
      Map.get(conn.params, "username", nil),
      Map.get(conn.params, "email_address", nil),
      Map.get(conn.params, "first_name", nil),
      Map.get(conn.params, "last_name", nil)
    }
    cond do
      is_nil(username) ->
        conn
        |> put_status(400)
        |> assign(:jsonapi, %{"error" => "'username' field must be provided"})
      is_nil(email_address) ->
        conn
        |> put_status(400)
        |> assign(:jsonapi, %{"error" => "'email_address' field must be provided"})
      is_nil(first_name) ->
        conn
        |> put_status(400)
        |> assign(:jsonapi, %{"error" => "'first_name' field must be provided"})
      is_nil(last_name) ->
        conn
        |> put_status(400)
        |> assign(:jsonapi, %{"error" => "'last_name' field must be provided"})
      true ->
        token = List.last(String.split(List.first(get_req_header(conn, "authorization"))))

        case Utils.is_valid_token(token) do
          true ->
            profile = Repo.get(Profile, username)
            case is_nil(profile) do
              true ->
                conn
                |> put_resp_content_type("application/json")
                |> send_resp(404, Poison.encode!(%{"error" => "Profile not found"}))
              false ->
                case Profile.update(profile, %{"username"=> username, "email_address" => email_address, "first_name" => first_name, "last_name" => last_name}) do
                  {:ok, updated_profile}->
                    conn
                    |> put_resp_content_type("application/json")
                    |> send_resp(200, Poison.encode!(%{:data => updated_profile}))
                  :error ->
                    conn
                    |> put_resp_content_type("application/json")
                    |> send_resp(500, Poison.encode!(%{"error" => "An unexpected error happened"}))
                end
            end
          false ->
            conn
            |>put_resp_content_type("application/json")
            |>send_resp(401,Poison.encode!(%{:error=>"Unauthorized"}))
        end
    end
  end

end