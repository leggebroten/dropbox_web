defmodule DropboxApi.GraphQL do
  use HTTPoison.Base

  def execute(query_or_mutation, variables) do
    do_post(query_or_mutation, variables)
  end

  defp do_post(query_or_mutation, variables) do
    payload = %{query: query_or_mutation, variables: variables}

#    url = get_env(:url) || "localhost:8001/graphql"
  url  = "localhost:8001/graphql"

    response = post(url, payload)
    IO.inspect(response, label: "inv graphql.ex:11 (response)", pretty: true)

    case response do
      {:ok, %{status_code: 200, body: %{data: data}}} ->
        {:ok, data}

      _err ->
        IO.puts "error #{_err}"
        _err
    end
  end

  @impl true
  def process_request_headers(headers) do
    headers ++ [{"Content-Type", "application/json"}]
  end

  @impl true
  def process_request_body(body) do
    Jason.encode!(body)
  end

  @impl true
  def process_response_body(body) do
    case Jason.decode(body, keys: :atoms) do
      {:ok, json} -> json
      _error -> body
    end
  end
end