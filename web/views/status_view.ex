defmodule JokenPhoenix.StatusView do
  use JokenPhoenix.Web, :view

  def render("status.json", %{status: status}) do
    status
  end

end
