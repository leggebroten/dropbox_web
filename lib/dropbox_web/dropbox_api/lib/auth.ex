defmodule DropboxApi.Auth do
  alias DropboxApi.GraphQL

  def get_authorization_url do
    {:ok, %{authorization: %{authorizationUrl: auth_url}}} =
      GraphQL.execute(authorization_query(), "")

    auth_url
  end

  def get_login_url,
    do: URI.merge(Application.fetch_env!(:dropbox_api, :url), "/login") |> to_string()

  defp authorization_query do
    """
    query {
      authorization {
        authorizationUrl
      }
    }
    """
  end
end
