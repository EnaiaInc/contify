defmodule ContifyAPI.Model.Source do
  @moduledoc false

  defstruct [:id, :name, :rank]

  @type t :: %__MODULE__{
          id: String.t() | nil,
          name: String.t() | nil,
          rank: integer() | nil
        }
end
