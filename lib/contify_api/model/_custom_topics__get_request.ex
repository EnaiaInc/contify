# NOTE: This file is auto generated by OpenAPI Generator 6.2.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule ContifyAPI.Model.CustomTopicsGetRequest do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :name,
    :rule
  ]

  @type t :: %__MODULE__{
          :name => String.t() | nil,
          :rule => String.t() | nil
        }
end

defimpl Poison.Decoder, for: ContifyAPI.Model.CustomTopicsGetRequest do
  def decode(value, _options) do
    value
  end
end
