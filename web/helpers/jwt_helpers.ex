defmodule JokenPhoenix.JWTHelpers do
  import Joken, except: [verify: 1]

  @doc """
  use for verification via plug
  issuer should be our auth0 domain
  app_metadata must be present in id_token
  """
  def verify do
    %Joken.Token{}
    |> with_json_module(Poison)
    |> with_signer(hs256(config[:app_secret]))
    |> with_validation("aud", &(&1 == config[:app_id]))
    |> with_validation("exp", &(&1 > current_time))
    |> with_validation("iat", &(&1 <= current_time))
    |> with_validation("iss", &(&1 == config[:app_baseurl]))
  end

  @doc """
  Return error message for `on_error`
  """
  def error(conn, _msg) do
    {conn, %{:errors => %{:detail => "unauthorized"}}}
  end

  defp config, do: Application.get_env(:joken_phoenix, :auth0)
end
