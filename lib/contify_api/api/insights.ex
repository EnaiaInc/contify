defmodule ContifyAPI.Api.Insights do
  @moduledoc """
  API calls for endpoints tagged `Insights`.
  """

  alias ContifyAPI.Client
  alias ContifyAPI.Model.InsightsResponse

  @doc """
  Returns a paginated list of insights.

  Insights can be filtered by company, industry, topic, custom topic, location,
  content type, channel, source, language, keyword, or advanced query.

  ## Options

  - `:company_id`, `:industry_id`, `:topic_id`, `:custom_topic_id`,
    `:location_id`, `:content_type_id`, `:channel_id`, `:source_id` — filter IDs
  - `:language_id` (String.t) — language id (see language endpoint)
  - `:keyword` (String.t) — keyword filter
  - `:advanced_query` (String.t) — advanced search query
  - `:start_date`, `:end_date` (DateTime.t) — date range
  - `:page` (integer) — paginate
  - `:sort_by` (String.t) — sort order (date / relevance)

  ## Returns

  - `{:ok, InsightsResponse.t}` on success
  - `{:ok, ContifyAPI.Model.Error.t}` on 4xx with an error body
  - `{:error, Exception.t | Req.Response.t}` on transport/other failures
  """
  @spec insights(keyword()) ::
          {:ok, InsightsResponse.t() | ContifyAPI.Model.Error.t()}
          | {:error, Exception.t() | Req.Response.t()}
  def insights(params) do
    Client.new()
    |> Req.get(url: "/insights", params: params)
    |> ContifyAPI.Response.decode(InsightsResponse)
  end
end
