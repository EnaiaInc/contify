# NOTE: This file is auto generated by OpenAPI Generator 6.2.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule ContifyAPI.Model.WebhooksResponseHeaderParams do
  @moduledoc """
  Header params provided for webhook
  """

  @derive [Poison.Encoder]
  defstruct [
    :name,
    :secret
  ]

  @type t :: %__MODULE__{
          :name => String.t() | nil,
          :secret => String.t() | nil
        }
end

defimpl Poison.Decoder, for: ContifyAPI.Model.WebhooksResponseHeaderParams do
  def decode(value, _options) do
    value
  end
end
