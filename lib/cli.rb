class Cli
	attr_accessor :article_search_keywords, :view_articles_start_index

	def initialize
		self.article_search_keywords = []
		self.view_articles_start_index = 0
	end

	def run
		self.greeting
		next_step = self.articles_prompt
		articles_menu_logic(next_step)
	end

	def articles_prompt(first_time = true)
		Article.clear_all if !first_time
		api_response = self.search_for_articles
		api_articles = self.select_articles(api_response)
		self.make_articles(api_articles)
		self.articles_menu
	end

	def articles_menu_logic(next_step)
		case next_step 
			when "1"
			when "2"
				view_ten_articles(self.view_articles_start_index)
				articles_menu(first_time = false)
			when "3"
				next_step = self.articles_prompt(first_time = false)
				articles_menu_logic(next_step)
			when "4"
		end
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
		#expect arg api_response to be the output of #search_for_articles
		records_limit = ApiResponse.records_limit
		puts "How many of these articles would you like to select? (limit = #{records_limit})"
		records_requested = gets.chomp.to_i
		while records_requested > records_limit do
			puts "Please enter a number lower than #{records_limit}:"
			records_requested = gets.chomp.to_i
		end
		api_response.get_articles(records_requested)
	end

	def make_articles(api_articles)
		#expect input api_articles to be the output of #select_articles
		api_articles.each{|article_hash| Article.new_from_api_hash(article_hash)}
	end

	def articles_menu(first_time = true)
		first_time ? option_one_lang = "first" : option_one_lang = "next"
		puts "You've selected #{Article.all.length} articles. What would you like to do next?"
		puts "1: View details of the #{option_one_lang} 10 articles."
		puts "2: Search by a keyword and return snippets from all the selected articles with that keyword."
		puts "3: Do a new article search."
		puts "4: End program."
		puts "Please enter '1', '2', '3', or '4':"
		input = gets.chomp
		accepted_input = ['1', '2', '3', '4']
		while !accepted_input.include?(input) do
			puts "Invalid input, please enter '1', '2', '3', or '4':"
		end
		input
	end

	def view_ten_articles(start_index)
		Article.all[start_index...(start_index+10)].each.with_index(1) do |article, i|
			puts "#{i+start_index}: #{article.title}"
			puts "Publication Date: #{article.readable_publication_date}"
			puts "Url: #{article.web_url}"
			puts "-------------------------------------------------------"
			self.view_articles_start_index += 10
		end
	end

	def snippet_search_prompt

	end

	def view_snippet_results

	end

end


