class Scraper
	attr_accessor :article_url

	def initialize(article_url)
		self.article_url = article_url
	end

	def get_doc
		Nokogiri::HTML(open(self.article_url))
	end

	def get_article_body
		self.get_doc.css(".content__article-body").text.gsub(/\n{3,}/,"\n")
	end

	def get_snippet(search_term)
		body = self.get_article_body
		lowercase_term = search_term.downcase
		snippet_ary = body.scan(/[A-Z\s][^\\.;?!]*#{Regexp.quote(lowercase_term)}[^\\.;?!]*[.?!][A-Z\s][^\\.;?!]*/)
		snippet_ary += body.scan(/[A-Z\s][^\\.;?!]*#{Regexp.quote(lowercase_term.capitalize)}[^\\.;?!]*[.?!][A-Z\s][^\\.;?!]*/)
	end
end


