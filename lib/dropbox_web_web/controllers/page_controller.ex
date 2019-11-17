defmodule DropboxWebWeb.PageController do
  use DropboxWebWeb, :controller

  use HTTPoison.Base

  alias DropboxApi

#  plug(:authenticate)
# session plug

  def index(conn, _params) do
    Plug.Conn.fetch_cookies(conn)
    cookies = conn.cookies["bearer_token"]
    IO.inspect(cookies, label: "inv page_controller.ex:11 (cookies)", pretty: true)

    render(conn, "index.html")
  end

  def login(conn, _params) do
    redirect(conn, external: "http://localhost:8001/login")
  end
end
