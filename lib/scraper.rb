class Scraper
	attr_accessor :article_url

	def initialize(article_url)
		self.article_url = article_url
	end

	def get_doc
		Nokogiri::HTML(open(self.article_url))
	end

	def get_article_body
		self.get_doc.css(".content__article-body").text
	end

	# def get_first_sentences

	# end

	def get_snippet(search_term)
		body = self.get_article_body
		body.scan(/.+\..+#{Regexp.quote(search_term)}.+\..+\./)
	end
end

binding.pry
