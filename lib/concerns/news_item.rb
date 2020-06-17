class NewsItem
	def self.clear_all
		self.all.clear
	end

	def save
		self.class.all << self
	end
end