defmodule JokenPhoenix.AuthHelper do
  @behaviour Plug
  import Plug.Conn
  import Joken

  @doc """
  Function that will serve as a Plug for verifying metadata
  """

  def init(opts), do: opts

  def call(conn, _opts) do
    ["Bearer " <> incoming_token] = get_req_header(conn, "authorization")
    claims = incoming_token
    |> token
    |> peek

    case Map.get(claims, "role", "") do
      "admin" ->
        assign(conn, :admin, true)
      _ ->
        conn
        |> forbidden
    end
  end

  @doc """
  send 403 to client
  """
  def forbidden(conn) do
    msg = %{
      errors: %{
        details: "forbidden resource"
      }
    }
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(403, Poison.encode!(msg))
    |> halt
  end

end
