# NOTE: This file is auto generated by OpenAPI Generator 6.2.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule ContifyAPI.Model.WebhookGetRequest do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :name,
    :url,
    :headerName,
    :headerValue,
    :companyId,
    :industryId,
    :contentTypeId,
    :locationId,
    :sourceId,
    :channelId,
    :topicId,
    :customTopicId,
    :languageId,
    :keyword,
    :advancedQuery
  ]

  @type t :: %__MODULE__{
          :name => String.t() | nil,
          :url => String.t() | nil,
          :headerName => String.t() | nil,
          :headerValue => String.t() | nil,
          :companyId => String.t() | nil,
          :industryId => String.t() | nil,
          :contentTypeId => String.t() | nil,
          :locationId => String.t() | nil,
          :sourceId => String.t() | nil,
          :channelId => String.t() | nil,
          :topicId => String.t() | nil,
          :customTopicId => String.t() | nil,
          :languageId => String.t() | nil,
          :keyword => String.t() | nil,
          :advancedQuery => String.t() | nil
        }
end

defimpl Poison.Decoder, for: ContifyAPI.Model.WebhookGetRequest do
  def decode(value, _options) do
    value
  end
end
