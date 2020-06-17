require "spec_helper"

RSpec.describe "ApiResponse" do 
let(:api_response) {ApiResponse.new(["remote","tech","jobs"])}
	
	describe "#generate_search_url" do
		it "returns a url that is formatted correctly for The Guardian API" do
			expect(api_response.generate_search_url).to eq("https://content.guardianapis.com/search?q=remote%20AND%20tech%20AND%20jobs&api-key=62e6b16d-8157-43d2-ab3a-647afb341c7e&page=1")
		end
	end

	describe "#get_response_page" do
		it "returns somethings along the lines of the expected json format of data" do
			standard_keys = ["status", "total", "startIndex", "pageSize", "currentPage", "pages", "orderBy", "results"]
			response = api_response.get_response_page
			standard_keys.each do |key|
				expect(response.values.first.keys).to include(key)
			end
		end
	end

	describe "#get_results" do
		it "returns an array of hashes, one hash for each resulting article on a response page" do
			required_keys = ["webPublicationDate", "webTitle", "webUrl"]
			results = api_response.get_results(1)
			required_keys.each do |key|
				expect(results.first.keys).to include(key)
			end
		end
	end
end