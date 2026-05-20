defmodule ContifyAPI.Model.InsightCompany do
  @moduledoc false

  defstruct [:id, :logo, :name, :url]

  @type t :: %__MODULE__{
          id: String.t() | nil,
          logo: String.t() | nil,
          name: String.t() | nil,
          url: String.t() | nil
        }
end
