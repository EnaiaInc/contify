defmodule ContifyAPI.Model.WebhooksResponseQueryParams do
  @moduledoc "Query params provided for a webhook."

  defstruct [
    :advanced_query,
    :channel_id,
    :company_id,
    :content_type_id,
    :custom_topic_id,
    :industry_id,
    :keyword,
    :language_id,
    :location_id,
    :source_id,
    :topic_id
  ]

  @type t :: %__MODULE__{
          advanced_query: String.t() | nil,
          channel_id: String.t() | nil,
          company_id: String.t() | nil,
          content_type_id: String.t() | nil,
          custom_topic_id: String.t() | nil,
          industry_id: String.t() | nil,
          keyword: String.t() | nil,
          language_id: String.t() | nil,
          location_id: String.t() | nil,
          source_id: String.t() | nil,
          topic_id: String.t() | nil
        }
end
