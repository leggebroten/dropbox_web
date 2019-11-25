defmodule DropboxWebWeb.PageController do
  use DropboxWebWeb, :controller

  use HTTPoison.Base

  alias DropboxApi

  #  plug(:authenticate)
  # session plug

  def index(conn, _params) do
    Plug.Conn.fetch_cookies(conn)

    conn
    |> merge_assigns(bearer_token: conn.cookies["bearer_token"])
    |> render("index.html")
  end

  def login(conn, _params) do
    redirect(conn, external: DropboxApi.get_authorization_url())
  end
end
