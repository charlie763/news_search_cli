require 'dotenv/load'
require 'open-uri'
require 'json'
require 'nokogiri'
require 'date'
require 'colorize'


require_relative './concerns/news_item.rb'
require_relative './news_search_cli/api_response.rb'
require_relative './news_search_cli/scraper.rb'
require_relative './news_search_cli/article.rb'
require_relative './news_search_cli/snippet.rb'
require_relative './news_search_cli/cli.rb'