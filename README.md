# NewsSearchCli

The News Search CLI is a Ruby CLI application that allows the user to search news articles and then pull text snippets from across an array of returned artcles. For example, the user could search for articles that match the keywords "technology," "remote," and "work" and then return snippets with the word "Google," if they were interested in learning about Google's remote work policy. 

Currently the applications utilizes the [The Guardian's API](https://open-platform.theguardian.com/documentation/) and scrapes directly from individual Guardian article webpages. This is an MVP proof of concept. The hope is that this application will be extensible to other news and media sources.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'news_search_cli'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install news_search_cli

## Usage

Execute `bin/news_search` to start the program. CLI prompts will lead the user through the rest of the program.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/news_search_cli. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/news_search_cli/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the NewsSearchCli project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/news_search_cli/blob/master/CODE_OF_CONDUCT.md).
