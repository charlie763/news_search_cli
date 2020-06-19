class Article < NewsItem
	@@all = []
	attr_accessor :title, :publication_date, :web_url, :body 

	def initialize(title, publication_date, web_url, extra_kwargs_hash = {})
		self.title = title
		self.publication_date = publication_date
		self.web_url = web_url
		extra_kwargs_hash.each do |k,v|
			self.class.attr_accessor(k.to_sym) if !self.methods.include?(k.to_sym)
      self.send("#{k}=", v)
		end
		self.save
	end

	def self.new_from_api_hash(api_hash)
		required_args = ["webPublicationDate", "webTitle", "webUrl"]
		extra_kwargs_hash = api_hash.select{|k,v| !required_args.include?(k)}
		self.new(api_hash["webTitle"], api_hash["webPublicationDate"], api_hash["webUrl"], extra_kwargs_hash)
	end

	def self.all
		@@all
	end

	def self.find_article_by_title(title)
		self.all.detect{|article| article.title == title}
	end

	def readable_publication_date
		#expect "2019-06-11T18:00:14Z" from guardian"
		date = Date.parse(self.publication_date)
		"#{Date::MONTHNAMES[date.month]} #{date.day}, #{date.year}"
	end

	def snippets
		Snippet.all.select{|snippet| snippet.article = self}
	end
end