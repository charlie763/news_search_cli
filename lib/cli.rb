class Cli
	attr_accessor :article_search_keywords, :view_articles_start_index, :article_records_requested

	def initialize
		self.article_search_keywords = []
		self.view_articles_start_index = 0
		Article.clear_all
		Snippet.clear_all
	end

	def run
		self.greeting
		next_step = self.articles_prompt
		articles_menu_logic(next_step)
		self.goodbye
	end

	def articles_prompt(first_time = true)
		unless first_time
			Article.clear_all 
			self.article_search_keywords = []
		end
		api_response = self.search_for_articles
		api_articles = self.select_articles(api_response)
		self.make_articles(api_articles)
		self.articles_menu
	end

	def articles_menu(first_time = true)
		first_time ? option_one_lang = "first" : option_one_lang = "next"
		puts ""
		puts "You've selected #{Article.all.length} articles. What would you like to do next?"
		puts "1: View details of the #{option_one_lang} 10 articles."
		puts "2: Search by a keyword and return snippets from all the selected articles with that keyword."
		puts "3: Get article details by the article's title."
		puts "4: Do a new article search."
		puts "5: End program."
		puts "Please enter '1', '2', '3', '4', or '5':"
		input = gets.chomp
		puts ""
		accepted_input = ['1', '2', '3', '4', '5']
		while !accepted_input.include?(input) do
			puts "Invalid input, please enter '1', '2', '3', '4', or '5':"
			input = gets.chomp
		end
		input
	end

	def process_menu(first_time = true)
		next_step = self.articles_menu(first_time = first_time)
		self.articles_menu_logic(next_step)
	end

	def articles_menu_logic(next_step)
		case next_step 
			when "1"
				if self.view_articles_start_index >= self.article_records_requested
					puts "There are no more articles. Please do another article search or select another menu option:"
					self.process_menu(first_time = false)
				end
				self.view_ten_articles(self.view_articles_start_index)
				self.process_menu(first_time = false)
			when "2"
				self.snippet_search_prompt
				self.view_snippet_results
				self.process_menu(first_time = false)
			when "3"
				self.find_article_by_title_prompt
				self.process_menu
			when "4"
				next_step = self.articles_prompt(first_time = false)
				self.articles_menu_logic(next_step)
			when "5"
		end
	end

	def greeting
		puts "Welcome to the News Search and Summary App!"
		puts "Currently, you can search The Guardian for relevant articles and return a summary of article snippets related to your search."
	end

	def goodbye
		puts "Thanks for searching!"
		puts "Contact cwisoff@gmail.com if you have any feedback or would like to contribute."
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
		self.article_records_requested = gets.chomp.to_i
		while self.article_records_requested > records_limit do
			puts "Please enter a number lower than #{records_limit}:"
			self.article_records_requested = gets.chomp.to_i
		end
		api_response.get_articles(self.article_records_requested)
	end

	def make_articles(api_articles)
		#expect input api_articles to be the output of #select_articles
		api_articles.each{|article_hash| Article.new_from_api_hash(article_hash)}
	end

	def view_article(article)
			puts "#{article.title}"
			puts "Publication Date: #{article.readable_publication_date}"
			puts "Url: #{article.web_url}"
	end

	def view_full_article(article)
		standard_vars = [:@title, :@publication_date, :@web_url, :@body] 
		article.instance_variables.each do |var|
			unless standard_vars.include?(var)
				var_as_str = var.to_s.delete("@")
				var_value = article.send("#{var_as_str}")
				puts "#{var_as_str.capitalize}: #{var_value}"
			end
		end
		puts ""

		scraper = Scraper.new(article.web_url)
		article.body = scraper.get_article_body
		puts "Full Article:"
		puts "#{article.body}"
	end

	def view_ten_articles(start_index)
		Article.all[start_index...(start_index+10)].each.with_index(1) do |article, i|
			puts "-------------------------------------------------------"
			print "#{i+start_index}: "
			self.view_article(article)
			puts "-------------------------------------------------------" 
		end
		self.view_articles_start_index += 10
	end

	def find_article_by_title_prompt
		puts "Please enter the title of the article you'd like to find:"
		title_input = gets.chomp
		article = Article.find_article_by_title(title_input)
		if article 
			puts "-------------------------------------------------------"
			self.view_article(article) 
			self.view_full_article(article)
			puts "-------------------------------------------------------"
		else 
			puts ""
			puts "Sorry, there are no articles by that title. Search for a different title, or search for new articles."
		end
	end

	def snippet_search_prompt
		Snippet.clear_all
		puts "What keyword would you like to get snippets by?"
		search_term = gets.chomp
		puts ""
		puts "Thanks! Getting snippets from #{self.article_records_requested} articles."
		puts "This may take a second..."
		Article.all.each do |article|
			scraper = Scraper.new(article.web_url)
			snippet_text_ary = scraper.get_snippet(search_term)
			snippet_text_ary.each{|snippet_text| Snippet.new(snippet_text, article)}
		end
		puts "We found #{Snippet.all.length} snippet(s)."
	end

	def view_snippet_results
		puts "Here are the results:"
		puts "-------------------------------------------------------"
		Snippet.all.each do |snippet|
			puts "Article: #{snippet.article.title}"
			puts snippet.text.gsub("\n", " ")
			puts "-------------------------------------------------------"
		end
	end
end


