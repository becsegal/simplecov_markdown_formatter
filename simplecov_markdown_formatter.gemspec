# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)
require 'simplecov_markdown_formatter/version'

Gem::Specification.new 'simplecov_markdown_formatter' do |s|
  s.version     = SimpleCovMarkdownFormatter::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Becky Segal']
  s.email       = ['becsegal@gmail.com']
  s.homepage    = 'https://github.com/becsegal/simplecov_markdown_formatter'
  s.summary     = %(Markdown formatter for SimpleCov)
  s.description = s.summary
  s.license = 'MIT'

  s.files         = Dir['{lib}/**/*.*', '*.md']
  s.test_files    = Dir['{test}/**/*.*']
  s.require_paths = ['lib']

  s.required_ruby_version = '>= 2.4.0'
end
