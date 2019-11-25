defmodule DropboxApi do
  alias DropboxApi.Auth

  def get_authorization_url, do: Auth.get_authorization_url()

  def get_login_url, do: Auth.get_login_url()
end
