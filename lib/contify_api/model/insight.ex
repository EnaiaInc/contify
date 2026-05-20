defmodule ContifyAPI.Model.Insight do
  @moduledoc false

  defstruct [
    :attachments,
    :channel,
    :companies,
    :content_types,
    :custom_topics,
    :duplicates,
    :id,
    :image_url,
    :industries,
    :language,
    :locations,
    :previews,
    :pub_date,
    :source,
    :summary,
    :title,
    :topics,
    :url
  ]

  @type t :: %__MODULE__{
          attachments: [ContifyAPI.Model.Attachment.t()] | nil,
          channel: String.t() | nil,
          companies: [ContifyAPI.Model.InsightCompany.t()] | nil,
          content_types: [ContifyAPI.Model.Tags.t()] | nil,
          custom_topics: [ContifyAPI.Model.Tags.t()] | nil,
          duplicates: [ContifyAPI.Model.Duplicate.t()] | nil,
          id: String.t() | nil,
          image_url: String.t() | nil,
          industries: [ContifyAPI.Model.Tags.t()] | nil,
          language: ContifyAPI.Model.Language.t() | nil,
          locations: [ContifyAPI.Model.Tags.t()] | nil,
          previews: [ContifyAPI.Model.Preview.t()] | nil,
          pub_date: DateTime.t() | String.t() | nil,
          source: ContifyAPI.Model.Source.t() | nil,
          summary: String.t() | nil,
          title: String.t() | nil,
          topics: [ContifyAPI.Model.Tags.t()] | nil,
          url: String.t() | nil
        }
end
