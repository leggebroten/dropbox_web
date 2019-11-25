defmodule DropboxWebWeb.PageView do
  use DropboxWebWeb, :view

  def bearer_token(%Plug.Conn{assigns: %{bearer_token: bearer_token}}), do: bearer_token
end
