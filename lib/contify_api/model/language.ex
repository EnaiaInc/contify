defmodule ContifyAPI.Model.Language do
  @moduledoc false

  defstruct [:id, :name]

  @type t :: %__MODULE__{
          id: String.t() | nil,
          name: String.t() | nil
        }
end
