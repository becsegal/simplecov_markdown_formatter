# frozen_string_literal: true

require 'rspec'
require 'simplecov'
require 'simplecov_markdown_formatter'

SimpleCov.coverage_dir('tmp/coverage')

def enable_branch_coverage
  allow(SimpleCov).to receive(:branch_coverage?).and_return(true)
end

def source_fixture(filename)
  File.expand_path(File.join(File.dirname(__FILE__), 'fixtures', filename))
end

def markdown_output
  File.read('tmp/coverage/coverage.md')
end

def markdown_result(filename)
  file = File.read(source_fixture("#{filename}.md"))
  use_current_working_directory(file)
end

DEFAULT_WORKING_DIRECTORY = 'STUB_WORKING_DIRECTORY'
def use_current_working_directory(file)
  current_working_directory = File.expand_path('..', File.dirname(__FILE__))
  file.gsub!("/#{DEFAULT_WORKING_DIRECTORY}/", "#{current_working_directory}/")
  file
end
