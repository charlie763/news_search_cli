class NewsItem
	def self.clear_all
		self.call.clear
	end

	def save
		self.class.all << self
	end
end