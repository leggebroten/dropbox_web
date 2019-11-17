defmodule DropboxApi.Auth do
  alias DropboxApi.GraphQL

  def get_authorization_url do
    {:ok, %{authorization: %{authorizationUrl: auth_url }}}  = GraphQL.execute(authorization_query(), "")
    auth_url
  end

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