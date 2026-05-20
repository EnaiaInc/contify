defmodule ContifyAPI.Model.Error do
  @moduledoc """
  Describes a Contify API error in detail.
  """

  defstruct [:code, :fields, :message]

  @type t :: %__MODULE__{
          code: integer() | nil,
          fields: String.t() | nil,
          message: String.t() | nil
        }
end
