class Snippet < NewsItem
	@@all = []
	attr_accessor :text, :article

	def initialize(text, article)
		raise TypeError, "New Snippets must be passed an Article object as the second argument" if !article.is_a?(Article)
		self.text = text
		self.article = article
		self.save
	end

	def self.all 
		@@all
	end

end