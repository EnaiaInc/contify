defmodule ContifyTest do
  use ExUnit.Case, async: true

  alias ContifyAPI.Model

  describe "subscribe_to_webhook/1" do
    test "returns the created webhook on success" do
      Req.Test.expect(ContifyAPI.Client, fn conn ->
        assert conn.method == "POST"
        assert conn.request_path == "/v3/webhook/"

        Req.Test.json(conn, %{
          client_url: "https://www.apple.com/in/",
          created_on: "20 Oct, 2022",
          header_params: %{name: "", secret: ""},
          id: 522,
          name: "MyWebhook",
          query_params: %{
            advanced_query: "",
            channel_id: "",
            company_id: "",
            content_type_id: "",
            custom_topic_id: "",
            industry_id: "",
            keyword: "",
            language_id: "",
            location_id: "",
            source_id: "56",
            topic_id: ""
          },
          updated_on: "20 Oct, 2022"
        })
      end)

      assert {:ok, %Model.WebhooksResponse{id: 522, name: "MyWebhook"}} =
               Contify.subscribe_to_webhook(webhook_params())
    end

    test "returns a Contify error struct on 5xx with an error body" do
      Req.Test.expect(ContifyAPI.Client, fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.send_resp(500, ~s({
          "code": 100,
          "message": "Internal Error. Please check if you are providing all necessary details.",
          "fields": ""
        }))
      end)

      assert {:ok,
              %Model.Error{
                code: 100,
                fields: "",
                message:
                  "Internal Error. Please check if you are providing all necessary details."
              }} = Contify.subscribe_to_webhook(webhook_params())
    end
  end

  describe "search_company/1" do
    test "returns matching companies" do
      Req.Test.expect(ContifyAPI.Client, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/v3/search-company"

        Req.Test.json(conn, %{
          count: 30,
          next: "?page=2",
          previous: nil,
          results: [
            %{
              hq_country: "United States",
              hq_state: "Washington State",
              id: 697,
              logo: "//112233.contify.com/images/company/logo/microsoft-28536.PNG",
              name: "Microsoft Corporation",
              twitter: "https://twitter.com/microsoft",
              url: "https://www.microsoft.com/"
            }
          ]
        })
      end)

      assert {:ok,
              %Model.SearchCompanyGet200Response{
                count: 30,
                results: [%Model.Company{id: 697, name: "Microsoft Corporation"}]
              }} = Contify.search_company(name: "Microsoft")
    end
  end

  describe "request_company/2" do
    test "returns an acknowledgement struct" do
      Req.Test.expect(ContifyAPI.Client, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/v3/request-company"

        Req.Test.json(conn, %{
          message: "Your request was successful for the company.",
          name: "Microsoft",
          url: "microsoft.com"
        })
      end)

      assert {:ok, %Model.RequestCompanyGet200Response{name: "Microsoft"}} =
               Contify.request_company("Microsoft", "microsoft.com")
    end
  end

  describe "insights/1" do
    test "returns hydrated insights with nested structs" do
      Req.Test.expect(ContifyAPI.Client, fn conn ->
        assert conn.method == "GET"
        assert conn.request_path == "/v3/insights"

        Req.Test.json(conn, %{
          count: 1,
          next: nil,
          previous: nil,
          results: [
            %{
              channel: "News Websites",
              companies: [%{id: 1, name: "ACME"}],
              id: 23_010_537_039_801,
              industries: [%{id: 11, name: "Financial Services"}],
              language: %{id: "en", name: "English"},
              locations: [%{id: 97, name: "United States"}],
              pub_date: "2023-01-03T18:30:00Z",
              source: %{id: "553606", name: "Example News", rank: 2_147_483_647},
              summary: "Sample summary text.",
              title: "Sample Insight Title",
              topics: [%{id: 3154, name: "Regulatory and Legal"}],
              url: "https://example.com/article"
            }
          ]
        })
      end)

      assert {:ok, %Model.InsightsResponse{count: 1, results: [insight]}} =
               Contify.insights(company_id: 1)

      assert %Model.Insight{id: 23_010_537_039_801, title: "Sample Insight Title"} = insight
      assert %Model.Language{id: "en", name: "English"} = insight.language
      assert %Model.Source{id: "553606", name: "Example News"} = insight.source
      assert [%Model.InsightCompany{id: 1, name: "ACME"}] = insight.companies
      assert [%Model.Tags{id: 11, name: "Financial Services"}] = insight.industries
      assert [%Model.Tags{id: 97, name: "United States"}] = insight.locations
    end
  end

  defp webhook_params do
    %{
      advancedQuery: "",
      channelId: "",
      companyId: 678,
      contentTypeId: "",
      customTopicId: "",
      headerName: "",
      headerValue: "",
      industryId: "",
      keyword: "",
      languageId: "",
      locationId: "",
      name: "some name",
      sourceId: "",
      topicId: "",
      url: "some endpoint"
    }
  end
end
