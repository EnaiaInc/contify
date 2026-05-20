defmodule ContifyAPI.Model.Duplicate do
  @moduledoc false

  defstruct [:channel, :id, :source, :summary, :title, :url]

  @type t :: %__MODULE__{
          channel: String.t() | nil,
          id: String.t() | nil,
          source: ContifyAPI.Model.Source.t() | nil,
          summary: String.t() | nil,
          title: String.t() | nil,
          url: String.t() | nil
        }
end
