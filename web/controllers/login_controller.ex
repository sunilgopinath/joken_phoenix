defmodule JokenPhoenix.LoginController do
  use JokenPhoenix.Web, :controller
  import Joken

  def index(conn, _params) do
    token = %Joken.Token{}
    |> with_claims(%{user_id: 1})
    |> with_aud(config[:app_id])
    |> with_iss(config[:app_baseurl])
    |> with_exp
    |> with_iat
    |> sign(hs256(config[:app_secret]))
    |> get_compact

    render(conn, "login.json", token: token)
  end

  def admin(conn, _params) do
    token = %Joken.Token{}
    |> with_claims(%{role: "admin"})
    |> with_aud(config[:app_id])
    |> with_iss(config[:app_baseurl])
    |> with_exp
    |> with_iat
    |> sign(hs256(config[:app_secret]))
    |> get_compact

    render(conn, "login.json", token: token)
  end

  defp config, do: Application.get_env(:joken_phoenix, :auth0)
end
