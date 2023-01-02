defmodule ContifyTest do
  use ExUnit.Case

  describe "webhooks" do
    setup do
      Tesla.Mock.mock(fn
        %{method: :post} ->
          {:ok, %ContifyAPI.Model.WebhookGetRequest{}}
      end)

      :ok
    end

    test "subscribe to webhook" do
      webhook = %{
        name: "some name",
        url: "some endpoint",
        headerName: "",
        headerValue: "",
        companyId: 678,
        industryId: "",
        contentTypeId: "",
        locationId: "",
        sourceId: "",
        channelId: "",
        topicId: "",
        customTopicId: "",
        languageId: "",
        keyword: "",
        advancedQuery: ""
      }

      assert Contify.subscribe_to_webhook(webhook, "secret", "key")
      {:ok, %ContifyAPI.Model.WebhookGetRequest{}}
    end
  end

  describe "search_company" do
    setup do
      Tesla.Mock.mock(fn
        %{method: :post} ->
          {:ok,
           %ContifyAPI.Model.SearchCompanyGet200Response{
             count: 30,
             next: "?page=2",
             previous: nil,
             results: [
               %ContifyAPI.Model.Company{
                 id: 697,
                 name: "Microsoft Corporation",
                 url: "https://www.microsoft.com/",
                 hq_country: "United States",
                 hq_state: "Washington State",
                 logo: "//112233.contify.com/images/company/logo/microsoft-28536.PNG",
                 twitter: "https://twitter.com/microsoft",
                 youtube: "https://www.youtube.com/MICROSOFT",
                 facebook: "https://www.facebook.com/MicrosoftIndia",
                 google: "https://plus.google.com/+Microsoft",
                 linkedin: "https://www.linkedin.com/company/microsoft/"
               }
             ]
           }}
      end)

      :ok
    end

    test "search_company return results for searched company" do
      assert Contify.search_company([name: "Patagonia"], "secret", "key")
      {:ok, %ContifyAPI.Model.SearchCompanyGet200Response{}}
    end

    setup do
      Tesla.Mock.mock(fn
        %{method: :post} ->
          {:ok,
           %ContifyAPI.Model.RequestCompanyGet200Response{
             message: "Your request was successful for the company.",
             name: "Microsoft",
             url: "microsoft.com"
           }}
      end)

      :ok
    end

    test "request a company" do
      assert Contify.request_company("Patagonia", "patagonia.com", "secret", "key")
      {:ok, %ContifyAPI.Model.SearchCompanyGet200Response{}}
    end
  end
end
