defmodule ContifyAPI.Model.Company do
  @moduledoc false

  defstruct [
    :facebook,
    :google,
    :hq_country,
    :hq_state,
    :id,
    :linkedin,
    :logo,
    :name,
    :twitter,
    :url,
    :youtube
  ]

  @type t :: %__MODULE__{
          facebook: String.t() | nil,
          google: String.t() | nil,
          hq_country: String.t() | nil,
          hq_state: String.t() | nil,
          id: integer() | nil,
          linkedin: String.t() | nil,
          logo: String.t() | nil,
          name: String.t() | nil,
          twitter: String.t() | nil,
          url: String.t() | nil,
          youtube: String.t() | nil
        }
end
