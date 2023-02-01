defmodule ContifyTest do
  use ExUnit.Case, async: true

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

  describe "existing webhooks" do
    setup do
      Tesla.Mock.mock(fn
        %{method: :post} ->
          %Tesla.Env{
            status: 500,
            body:
              ~s({"code":100, "message": "Internal Error. Please check if you are providing all necessary details.", "fields": ""}
            )
          }
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

      assert {:error,
              %ContifyAPI.Model.Error{
                code: 100,
                fields: "",
                message:
                  "Internal Error. Please check if you are providing all necessary details."
              }} = Contify.subscribe_to_webhook(params)
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

  describe "insights" do
    setup do
      Tesla.Mock.mock(fn
        %{method: :get} ->
          %Tesla.Env{status: 200, body: ~s<{
             "count": 3,
             "next": null,
             "previous": null,
             "results": [
               {
                 "id": 23010537039801,
                 "title": "Ex-Broker Who Sold $4.8M In Schorsch REITs Plans To Fight Finra Charges",
                 "summary": "January 4, 2023 The Financial Industry Regulatory Authority’s Department of Enforcement has filed a disciplinary proceeding against a former National Securities Corporation broker who it said made unsuitable non-traded REIT recommendations to 16 customers, causing them to lose some $4.1 million as he racked up $290,000 in commissions.",
                 "url": "https://www.fa-mag.com/news/finra-says-ex-national-securities-corp--rep-lost-customers--4-1m-in-non-traded-reits-71340.html",
                 "pub_date": "2023-01-03T18:30:00Z",
                 "image_url": "https://www.fa-mag.com/images/logo_opengraph.jpg",
                 "channel": "News Websites",
                 "language": {"id": "en", "name": "English"},
                 "previews": [],
                 "duplicates": [],
                 "attachments": [],
                 "source": {
                   "id": "553606",
                   "name": "Fa-Mag",
                   "rank": 2147483647
                 },
                 "companies": [
                   {
                     "id": 1,
                     "name": "National Securities",
                     "logo": "//112233.contify.com/images/company/logo/national-securities-382528.png",
                     "url": "http://www.yournational.com/"
                   }
                 ],
                 "industries": [],
                 "topics": [{"id": 3154, "name": "Regulatory and Legal"}],
                 "custom_topics": [],
                 "locations": [{"id": 97, "name": "United States"}],
                 "content_types": [{"id": 3, "name": "News Articles"}]
               },
               {
                 "id": 22123034885021,
                 "title": "Draft of the Securities Markets and Investment Services Law",
                 "summary": "Last 12 of September the new Draft of the Securities Markets and Investment Services Law was published (the \\"Draft\\") which will be development through three Regulations on (i) investment services firms, (ii) financial instruments, and (iii) the supervisory powers of the Spanish National Securities Market Commission (the \\"SNSMC\\") The approval of the Draft will replace the current Royal Legislative Decree 4/2015, of 23 October, which approves the consolidated text of the Securities Market Law.",
                 "url": "https://www.osborneclarke.com/insights/draft-securities-markets-and-investment-services-law",
                 "pub_date": "2022-12-30T11:04:42Z",
                 "image_url": "https://www.osborneclarke.com/themes/custom/osborneclarke/assets/images/icon.png",
                 "channel": "Company Websites",
                 "language": {"id": "en", "name": "English"},
                 "previews": [],
                 "duplicates": [],
                 "attachments": [],
                 "source": {
                   "id": "399506",
                   "name": "Osborne Clarke",
                   "rank": 616156
                 },
                 "companies": [
                   {
                     "id": 1,
                     "name": "National Securities",
                     "logo": "//112233.contify.com/images/company/logo/national-securities-382528.png",
                     "url": "http://www.yournational.com/"
                   }
                 ],
                 "industries": [{"id": 11, "name": "Financial Services"}],
                 "topics": [{"id": 3154, "name": "Regulatory and Legal"}],
                 "custom_topics": [],
                 "locations": [{"id": 146, "name": "Spain"}],
                 "content_types": [{"id": 3, "name": "News Articles"}]
               },
               {
                 "id": 22122432520851,
                 "title": "Argentina reaches agreement with Uruguay for the exchange of financial information",
                 "summary": "The National Securities Commission (CNV) of Argentina announced this Thursday an agreement with the Central Bank of Uruguay for the exchange of information on companies, individuals and financial operations.",
                 "url": "https://www.riotimesonline.com/brazil-news/mercosur/argentina/argentina-reaches-agreement-with-uruguay-for-the-exchange-of-financial-information/",
                 "pub_date": "2022-12-23T22:17:20Z",
                 "image_url": "",
                 "channel": "News Websites",
                 "language": {"id": "en", "name": "English"},
                 "previews": [],
                 "duplicates": [],
                 "attachments": [],
                 "source": {
                   "id": "1121",
                   "name": "The Rio Times",
                   "rank": 291188
                 },
                 "companies": [
                   {
                     "id": 1,
                     "name": "National Securities",
                     "logo": "//112233.contify.com/images/company/logo/national-securities-382528.png",
                     "url": "http://www.yournational.com/"
                   },
                   {
                     "id": 749030,
                     "name": "Central Bank of Uruguay",
                     "logo": "//112233.contify.com/images/company/logo/central-bank-of-uruguay-479758.png",
                     "url": "https://www.bcu.gub.uy/"
                   }
                 ],
                 "industries": [
                   {"id": 1, "name": "Banking & Finance"},
                   {"id": 11, "name": "Financial Services"}
                 ],
                 "topics": [
                   {"id": 2501, "name": "Procurement and Sales"},
                   {"id": 3154, "name": "Regulatory and Legal"}
                 ],
                 "custom_topics": [],
                 "locations": [
                   {"id": 673, "name": "Argentina"},
                   {"id": 1908, "name": "Uruguay"}
                 ],
                 "content_types": [{"id": 3, "name": "News Articles"}]
               }
             ]
           }>}
      end)

      :ok
    end

    test "insights/1" do
      assert {:ok, %ContifyAPI.Model.InsightsResponse{} = insights} =
               Contify.insights(company_id: 1)

      assert insights.count == 3
    end
  end
end
