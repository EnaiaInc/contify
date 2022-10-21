# NOTE: This file is auto generated by OpenAPI Generator 6.2.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule ContifyAPI.Model.SearchCompanyGet200Response do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :count,
    :next,
    :previous,
    :result
  ]

  @type t :: %__MODULE__{
          :count => integer() | nil,
          :next => String.t() | nil,
          :previous => String.t() | nil,
          :result => [ContifyAPI.Model.Company.t()] | nil
        }
end

defimpl Poison.Decoder, for: ContifyAPI.Model.SearchCompanyGet200Response do
  import ContifyAPI.Deserializer

  def decode(value, options) do
    value
    |> deserialize(:result, :list, ContifyAPI.Model.Company, options)
  end
end
