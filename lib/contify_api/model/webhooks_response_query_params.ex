# NOTE: This file is auto generated by OpenAPI Generator 6.2.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule ContifyAPI.Model.WebhooksResponseQueryParams do
  @moduledoc """
  Query params provided for webhook
  """

  @derive [Poison.Encoder]
  defstruct [
    :company_id,
    :industry_id,
    :content_type_id,
    :location_id,
    :source_id,
    :channel_id,
    :topic_id,
    :custom_topic_id,
    :language_id,
    :keyword,
    :advanced_query
  ]

  @type t :: %__MODULE__{
          :company_id => String.t() | nil,
          :industry_id => String.t() | nil,
          :content_type_id => String.t() | nil,
          :location_id => String.t() | nil,
          :source_id => String.t() | nil,
          :channel_id => String.t() | nil,
          :topic_id => String.t() | nil,
          :custom_topic_id => String.t() | nil,
          :language_id => String.t() | nil,
          :keyword => String.t() | nil,
          :advanced_query => String.t() | nil
        }
end

defimpl Poison.Decoder, for: ContifyAPI.Model.WebhooksResponseQueryParams do
  def decode(value, _options) do
    value
  end
end
