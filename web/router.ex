defmodule JokenPhoenix.Router do
  use JokenPhoenix.Web, :router
  import Joken

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :api_auth do
    plug :accepts, ["json"]
    plug Joken.Plug,
          verify: &JokenPhoenix.JWTHelpers.verify/0,
          on_error: &JokenPhoenix.JWTHelpers.error/2
  end

  # create a new pipeline for admin: web/router.ex
  pipeline :api_admin do
    plug JokenPhoenix.AuthHelper
  end

  scope "/api/login", JokenPhoenix do
    pipe_through :api

    get "/", LoginController, :index
    get "/admin", LoginController, :admin
  end

  scope "/api", JokenPhoenix do
    pipe_through :api_auth

    get "/status", StatusController, :index
  end

  # add a new scope
scope "/api/admin", JokenPhoenix do
  pipe_through [:api_auth, :api_admin]

  get "/", StatusController, :admin
end
end
