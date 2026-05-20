defmodule ContifyAPI.Model.Tags do
  @moduledoc false

  defstruct [:id, :name]

  @type t :: %__MODULE__{
          id: integer() | nil,
          name: String.t() | nil
        }
end
