defmodule JokenPhoenix.LoginView do
  use JokenPhoenix.Web, :view

  def render("login.json", %{token: token}) do
    token
  end

end
