defmodule ContifyAPI.Model.WebhooksResponseHeaderParams do
  @moduledoc "Header params provided for a webhook."

  defstruct [:name, :secret]

  @type t :: %__MODULE__{
          name: String.t() | nil,
          secret: String.t() | nil
        }
end
