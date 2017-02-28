defmodule JokenPhoenix.Router do
  use JokenPhoenix.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :api_auth do
    plug :accepts, ["json"]
    plug Joken.Plug,
          verify: &JokenPhoenix.JWTHelpers.verify/0,
          on_error: &JokenPhoenix.JWTHelpers.error/2
  end

  scope "/api", JokenPhoenix do
    pipe_through :api_auth

    get "/status", StatusController, :index
  end

  scope "/api/login", JokenPhoenix do
    pipe_through :api

    get "/", LoginController, :index
  end
end
