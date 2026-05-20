defmodule ContifyAPI.Model.Attachment do
  @moduledoc false

  defstruct [:source, :url]

  @type t :: %__MODULE__{
          source: String.t() | nil,
          url: String.t() | nil
        }
end
