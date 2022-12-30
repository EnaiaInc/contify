# NOTE: This file is auto generated by OpenAPI Generator 6.2.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule ContifyAPI.Model.SearchSourceGet200Response do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :count,
    :results,
    :previous,
    :next
  ]

  @type t :: %__MODULE__{
          :count => integer() | nil,
          :results => [ContifyAPI.Model.ContentSource.t()] | nil,
          :previous => String.t() | nil,
          :next => String.t() | nil
        }
end

defimpl Poison.Decoder, for: ContifyAPI.Model.SearchSourceGet200Response do
  import ContifyAPI.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:results, :list, ContifyAPI.Model.ContentSource, options)
  end
end