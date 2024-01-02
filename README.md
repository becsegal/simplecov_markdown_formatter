# Markdown formatter for SimpleCov

***Note: To learn more about SimpleCov, check out the main repo at [SimpleCov](https://github.com/simplecov-ruby/simplecov)***

Generates a formatted markdown report of your [SimpleCov](https://github.com/simplecov-ruby/simplecov) ruby code coverage results on ruby 2.4+. Intended to display results from Github actions.

Borrowed heavily from [simplecov_json_formatter](https://github.com/codeclimate-community/simplecov_json_formatter).

## Overview

You can expect for this gem to produce a `coverage.md` file, located at the `coverage` folder.

Depending on your `SimpleCov`'s settings you will experiment different outcomes. Particularly depending on which type of coverage are you running `SimpleCov` with:

- If you configure `SimpleCov` to run with `branch` coverage you should expect an output formatted like [sample_with_branch.md](https://github.com/becsegal/simplecov_markdown_formatter/blob/main/spec/fixtures/sample_with_branch.md)
- Otherwise you should expect an output formatted like [sample.md](https://github.com/becsegal/simplecov_markdown_formatter/blob/main/spec/fixtures/sample.md)


## Copyright

See [License](https://github.com/becsegal/simplecov_markdown_formatter/blob/master/LICENSE)
