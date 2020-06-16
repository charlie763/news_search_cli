require "spec_helper"

RSpec.describe "ApiResponse" do 
let(:api_response) {ApiResponse.new(["remote","tech","jobs"])}
	# describe "#initialize" do
	# 	it "accepts base_path and api_key args" do
	# 		new_requester = ApiRequester.new("http://content.guardianapis.com", "62e6b16d-8157-43d2-ab3a-647afb341c7e")
	# 		new_requester_base_path = new_requester.instance_variable_get(:@base_path)
	# 		expect(new_requester_base_path).to eq("http://content.guardianapis.com")
	# 		new_requester_api_key = new_requester.instance_variable_get(:@api_key)
	# 		expect(new_requester_api_key).to eq("62e6b16d-8157-43d2-ab3a-647afb341c7e")
	# 	end

		# it "sets api_key to default, but puts a warning message if no api_key given" do
		# 	new_requester2 = ApiRequester.new("http://content.guardianapis.com")
		# 	expect($stdout).to receive(:puts).with("WARNING - No api_key, please make sure the API doesn't require a key.")

		# 	ApiRequester.new("test")
		# end
	#end
	
	describe "#generate_search_url" do
		it "returns a url that is formatted correctly for The Guardian API" do
			expect(api_response.generate_search_url).to eq("https://content.guardianapis.com/search?q=technology%20AND%20remote%20AND%20jobs&api-key=62e6b16d-8157-43d2-ab3a-647afb341c7e")
		end
	end

	describe "#get_response_page" do
		it "returns somethings along the lines of the expected json format of data" do
			standard_keys = ["status", "total", "startIndex", "pageSize", "currentPage", "pages", "orderBy", "results"]
			response = api_response.get_response
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
				expect(response.values.first.keys).to include(key)
			end
		end
	end
end