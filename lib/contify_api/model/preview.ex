defmodule ContifyAPI.Model.Preview do
  @moduledoc false

  defstruct [:id, :summary, :title, :url]

  @type t :: %__MODULE__{
          id: integer() | nil,
          summary: String.t() | nil,
          title: String.t() | nil,
          url: String.t() | nil
        }
end
