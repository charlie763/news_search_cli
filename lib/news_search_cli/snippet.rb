class Snippet < NewsItem
	@@all = []
	attr_accessor :text, :article

	def initialize(text, article)
		self.text = text
		self.article = article
		self.save
	end

	def self.all 
		@@all
	end

end