# NOTE: This file is auto generated by OpenAPI Generator 6.2.0 (https://openapi-generator.tech).
# Do not edit this file manually.

defmodule ContifyAPI.Model.Company do
  @moduledoc """

  """

  @derive [Poison.Encoder]
  defstruct [
    :id,
    :name,
    :url,
    :hq_country,
    :hq_state,
    :logo,
    :twitter,
    :youtube,
    :facebook,
    :google,
    :linkedin
  ]

  @type t :: %__MODULE__{
          :id => integer() | nil,
          :name => String.t() | nil,
          :url => String.t() | nil,
          :hq_country => String.t() | nil,
          :hq_state => String.t() | nil,
          :logo => String.t() | nil,
          :twitter => String.t() | nil,
          :youtube => String.t() | nil,
          :facebook => String.t() | nil,
          :google => String.t() | nil,
          :linkedin => String.t() | nil
        }
end

defimpl Poison.Decoder, for: ContifyAPI.Model.Company do
  def decode(value, _options) do
    value
  end
end
