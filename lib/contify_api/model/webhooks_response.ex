defmodule ContifyAPI.Model.WebhooksResponse do
  @moduledoc false

  defstruct [
    :client_url,
    :created_on,
    :header_params,
    :id,
    :name,
    :query_params,
    :updated_on
  ]

  @type t :: %__MODULE__{
          client_url: String.t() | nil,
          created_on: String.t() | nil,
          header_params: ContifyAPI.Model.WebhooksResponseHeaderParams.t() | map() | nil,
          id: integer() | nil,
          name: String.t() | nil,
          query_params: ContifyAPI.Model.WebhooksResponseQueryParams.t() | map() | nil,
          updated_on: String.t() | nil
        }
end
