defmodule ContifyTest do
  use ExUnit.Case

  describe "webhooks" do
    setup do
      Tesla.Mock.mock(fn
        %{method: :post} ->
          %Tesla.Env{status: 200, body: ~s({
            "id": 522,
            "name": "MyWebhook",
            "client_url": "https://www.apple.com/in/",
            "header_params": {
              "name": "",
              "secret": ""
            },
            "query_params": {
              "keyword": "",
              "topic_id": "",
              "source_id": "56",
              "channel_id": "",
              "company_id": "",
              "industry_id": "",
              "language_id": "",
              "location_id": "",
              "advanced_query": "",
              "content_type_id": "",
              "custom_topic_id": ""
            },
            "created_on": "20 Oct, 2022",
            "updated_on": "20 Oct, 2022"
          })}
      end)

      :ok
    end

    test "subscribe to webhook" do
      params = %{
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

      assert {:ok, %ContifyAPI.Model.WebhooksResponse{id: 522}} =
               Contify.subscribe_to_webhook(params)
    end
  end

  describe "search_company" do
    setup do
      Tesla.Mock.mock(fn
        %{method: :get} ->
          %Tesla.Env{status: 200, body: ~s({ 
             "count": 30,
             "next": "?page=2",
             "previous": null,
             "results": [
               {
                 "id": 697,
                 "name": "Microsoft Corporation",
                 "url": "https://www.microsoft.com/",
                 "hq_country": "United States",
                 "hq_state": "Washington State",
                 "logo": "//112233.contify.com/images/company/logo/microsoft-28536.PNG",
                 "twitter": "https://twitter.com/microsoft",
                 "youtube": "https://www.youtube.com/MICROSOFT",
                 "facebook": "https://www.facebook.com/MicrosoftIndia",
                 "google": "https://plus.google.com/+Microsoft",
                 "linkedin": "https://www.linkedin.com/company/microsoft/"
               }
             ]
           })}
      end)

      :ok
    end

    test "search_company return results for searched company" do
      assert {:ok,
              %ContifyAPI.Model.SearchCompanyGet200Response{
                results: [%ContifyAPI.Model.Company{id: 697}]
              }} = Contify.search_company(name: "Patagonia")
    end
  end

  describe "request_company" do
    setup do
      Tesla.Mock.mock(fn
        %{method: :get} ->
          %Tesla.Env{status: 200, body: ~s({
             "message": "Your request was successful for the company.",
             "name": "Microsoft",
             "url": "microsoft.com"
           })}
      end)

      :ok
    end

    test "request a company" do
      assert {:ok, %ContifyAPI.Model.RequestCompanyGet200Response{}} =
               Contify.request_company("Patagonia", "patagonia.com")
    end
  end
end
