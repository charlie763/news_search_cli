class Article < NewsItem
	@@all = []
	attr_accessor :title, :publication_date, :web_url 

	def initialize(title, publication_date, web_url, extra_kwargs_hash = {})
		self.title = title
		self.publication_date = publication_date
		self.web_url = web_url
		extra_kwargs_hash.each do |k,v|
			self.class.attr_accessor(k.to_sym)
      self.send("#{k}=", v)
		end
	end

	def new_from_api_hash(api_hash)

	end

	def self.all

	end

	def readable_publication_date

	end

	def snippets

	end

	def view_article

	end
end