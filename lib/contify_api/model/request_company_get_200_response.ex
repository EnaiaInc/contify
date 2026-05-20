defmodule ContifyAPI.Model.RequestCompanyGet200Response do
  @moduledoc false

  defstruct [:message, :name, :url]

  @type t :: %__MODULE__{
          message: String.t() | nil,
          name: String.t() | nil,
          url: String.t() | nil
        }
end
