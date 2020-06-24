RSpec.describe 'Cli' do
let(:cli_instance) {Cli.new}

	describe "#articles_prompt" do
		it "calls the #search_for_articles method" do
			# allow(input).to receive('y')
						allow(cli_instance).to receive(:gets).and_return('y')
			allow(cli_instance).to receive(:gets).and_return('n')
			#allow(cli_instance).to receive(:gets).and_return('2')
		
			expect(self).to receive(:search_for_articles).with(no_args)
			cli_instance.articles_prompt

		end
	end

	describe "#search_for_articles" do
		it "asks for an initial search term" do
		end

		it "tells the user how many initial resulst there are and asks if they'd like to refine the search or not" do

		end

		it "keeps adding search terms until the user tells it to stop" do

		end

		it "returns the Api Response, once the user has added all the search terms they want" do

		end

		it "tests something" do

		end
	end	
end