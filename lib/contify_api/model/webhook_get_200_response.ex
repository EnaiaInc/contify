defmodule ContifyAPI.Model.WebhookGet200Response do
  @moduledoc """
  Envelope returned by `GET /webhook/`.
  """

  defstruct [:count, :next, :previous, :results]

  @type t :: %__MODULE__{
          count: integer() | nil,
          next: String.t() | nil,
          previous: String.t() | nil,
          results: [ContifyAPI.Model.WebhooksResponse.t()] | nil
        }
end
