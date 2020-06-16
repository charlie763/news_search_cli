class Cli
	attr_accessor :article_search_keywords

	def initialize
		self.article_search_keywords = []
	end

	def greeting
		puts "Welcome to the News Search and Summary App!"
		puts "Currently, you can search The Guardian for relevant articles and return a summary of article snippets related to your search."
	end

	def add_search_keyword(keyword)
		self.article_search_keywords << keyword
	end

	def search_for_articles
		puts "Please enter a search term:"
		input = gets.chomp
		self.add_search_keyword(input)

		while input != "n" do
			api_response = ApiResponse.new(article_search_keywords)
			response = api_response.get_response_page

			puts "Your search returned #{api_response.total_articles} articles."
			puts "Would you like to add more search terms to refine your search? (y/n)"
			input = gets.chomp

			while input != "y" && input != "n" do
				puts "'y' and 'n' are the only accepted inputs:"
				input = gets.chomp
			end

			if input == 'y' 
				puts "Please enter another search term:"
				input = gets.chomp
				self.add_search_keyword(input)
			end
		end
		api_response
	end

	def select_articles(api_response)
		records_limit = ApiResponse.records_limit
		puts "How many of these articles would you like to view? (limit = #{records_limit})"
		records_requested = gets.chomp.to_i
		while records_requested > records_limit do
			puts "Please enter a number lower than #{records_limit}:"
			records_requested = gets.chomp.to_i
		end
		api_response.get_articles(records_requested)
	end

	def make_articles(api_articles)
		api_articles.each{Article.new}
	end
end


