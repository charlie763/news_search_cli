require_relative 'lib/news_search_cli/version'

Gem::Specification.new do |spec|
  spec.name          = "news_search_cli"
  spec.version       = NewsSearchCli::VERSION
  spec.authors       = ["charlie763"]
  spec.email         = ["cwisoff@gmail.com"]

  spec.summary       = "The News Search CLI is a CLI application that allows the user to search news articles and then pull text snippets from across an array of returned artcles."
  spec.description   = "Currently the applications utilizes the [The Guardian's API](https://open-platform.theguardian.com/documentation/) and scrapes directly from individual Guardian article webpages. This is an MVP proof of concept. The hope is that this application will be extensible to other news and media sources."
  spec.homepage      = "https://github.com/charlie763/news_search_cli"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/charlie763/news_search_cli"
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rspec', "~> 3.0"
  spec.add_development_dependency "rake", ">= 12.3.3"
  spec.add_dependency 'nokogiri', '1.10.8'

end
