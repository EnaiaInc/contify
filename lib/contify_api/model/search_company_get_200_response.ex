defmodule ContifyAPI.Model.SearchCompanyGet200Response do
  @moduledoc false

  defstruct [:count, :next, :previous, :results]

  @type t :: %__MODULE__{
          count: integer() | nil,
          next: String.t() | nil,
          previous: String.t() | nil,
          results: [ContifyAPI.Model.Company.t()] | nil
        }
end
