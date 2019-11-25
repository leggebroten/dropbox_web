defmodule DropboxApi.GraphQL do
  use HTTPoison.Base
  require Logger

  def execute(query_or_mutation, variables) do
    do_post(query_or_mutation, variables)
  end

  defp do_post(query_or_mutation, variables) do
    payload = %{query: query_or_mutation, variables: variables}

    response = post(url(), payload)

    log(payload, response)

    case response do
      {:ok, %{status_code: 200, body: %{data: data}}} ->
        {:ok, data}

      error ->
        error
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

  defp url, do: URI.merge(Application.fetch_env!(:dropbox_api, :url), "/graphql")

  defp log(payload, {:ok, response}) do
    level = if response.status_code >= 500, do: :warn, else: :debug
    variables = payload.variables

    Logger.log(level, fn ->
      [
        "[GraphQL] ",
        to_string(response.status_code),
        " POST ",
        response.request_url,
        "\n#{payload.query}",
        "[Variables]\n#{Jason.encode!(variables)}",
        "\n[Data]\n",
        Jason.encode!(response.body[:data]),
        "\n[Errors]\n",
        Jason.encode!(response.body[:errors])
      ]
    end)
  end

  defp log(_payload, _response), do: IO.puts("bad log")
end
