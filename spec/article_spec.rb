RSpec.describe "Article" do
let(:test_article) {Article.new("2020-03-04T05:00:32Z", "Coronavirus: Google leads tech charge to work from home", "https://www.theguardian.com/world/2020/mar/04/coronavirus-google-tech-dublin-twitter-work-from-home")}
	describe "#initialize" do
		it "initializes with a :web_publication_date, :web_title, and :web_url" do
			expect(test_article.instance_variable_get(:web_publication_date)).to eq("2020-03-04T05:00:32Z")
			expect(test_article.instance_variable_get(:web_title)).to eq("Coronavirus: Google leads tech charge to work from home")
			expect(test_article.instance_variable_get(:web_publication_date)).to eq("https://www.theguardian.com/world/2020/mar/04/coronavirus-google-tech-dublin-twitter-work-from-home")
		end

		it "can initialize with additional arguments" do 
			test_article2 = Article.new("date","title","url", sectionName: "World News")
			expect(test_article.instance_variable_get(:sectionName)).to eq("World News")
		end
	end

	# describe "instance variables" do
	# 	it "has methods for setting and getting :sectionName, :webPublicationDate, :webTitle, and :webUrl attributes" do

	# 	end
	# end

	describe ".clear_all" do
		it "can clear all instances of Article for the @@all class variable (for new Searches)" do

		end
	end

	descibe "#snippets" do
		it "can return all the snippets associated with the Article" do

		end
	end

	describe "#view_article" do
		it "will return the body of the article" do

		end
	end
	
end