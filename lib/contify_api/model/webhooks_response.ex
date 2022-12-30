# NOTE: This file is auto generated by OpenAPI Generator 6.2.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule ContifyAPI.Model.WebhooksResponse do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :id,
    :name,
    :client_url,
    :header_params,
    :query_params,
    :created_on,
    :updated_on
  ]

  @type t :: %__MODULE__{
          :id => integer() | nil,
          :name => String.t() | nil,
          :client_url => String.t() | nil,
          :header_params => ContifyAPI.Model.WebhooksResponseHeaderParams.t() | nil,
          :query_params => ContifyAPI.Model.WebhooksResponseQueryParams.t() | nil,
          :created_on => String.t() | nil,
          :updated_on => String.t() | nil
        }
end

defimpl Poison.Decoder, for: ContifyAPI.Model.WebhooksResponse do
  import ContifyAPI.Deserializer

  def decode(value, options) do
    value
    |> deserialize(
      :header_params,
      :struct,
      ContifyAPI.Model.WebhooksResponseHeaderParams,
      options
    )
    |> deserialize(:query_params, :struct, ContifyAPI.Model.WebhooksResponseQueryParams, options)
  end
end