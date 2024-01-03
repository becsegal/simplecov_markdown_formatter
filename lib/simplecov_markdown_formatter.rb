# frozen_string_literal: true

module SimpleCov
  module Formatter
    class MarkdownFormatter
      FILENAME = 'coverage.md'

      def format(result)
        @result = result
        export
        puts output_message
      end

      private

      def export
        File.open(File.join(SimpleCov.coverage_path, FILENAME), 'w') do |file|
          file << "#{summary_header}\n"
          file << "#{files_summary}\n"
          file << "#{line_coverage_summary}\n"
          file << "#{branch_coverage_summary}\n" if SimpleCov.branch_coverage?
          file << groups_tables if @result.groups.any?
          file << files_table(@result.files) unless @result.groups.any?
        end
      end

      def summary_header
        str = +"## #{coverage_emoji(@result.covered_percent)} #{formatted_pct(@result.covered_percent)} of lines covered"
        str += " / #{formatted_pct(covered_branches_percent)} of branches covered" if SimpleCov.branch_coverage?
        str
      end

      def files_summary
        "**#{@result.files.size}** files in total"
      end

      def line_coverage_summary
        "**#{@result.total_lines}** relevant lines with **#{@result.covered_lines}** covered and **#{@result.missed_lines}** missed"
      end

      def branch_coverage_summary
        "**#{@result.total_branches}** branches with **#{@result.covered_branches}** covered and **#{@result.missed_branches}** missed"
      end

      def groups_tables
        str = +''
        @result.groups.each do |group_name, files|
          str << "### #{group_name}\n"
          str << files_table(files)
        end
        str
      end

      def files_table(files)
        files = files.to_a.sort_by(&:covered_percent)
        str = +''
        str << "#{table_header}\n"
        files.each do |source_file|
          str << "#{file_table_row(source_file)}\n"
        end
        str
      end

      def table_header
        str = +'| Filename | Line Coverage | Lines of Code | Covered Lines | Hits/Line |'
        str << ' Branch Coverage | Branches | Covered Branches | Missed Branches |' if SimpleCov.branch_coverage?
        str << "\n| --- | --- | --- | --- | --- |"
        str << ' --- | --- | --- | --- |' if SimpleCov.branch_coverage?
        str
      end

      def file_table_row(source_file)
        if SimpleCov.branch_coverage?
          "#{file_line_columns(source_file)} #{file_branch_columns(source_file)}"
        else
          file_line_columns(source_file)
        end
      end

      def file_line_columns(source_file)
        "| #{filename(source_file.filename)} "\
        "| #{coverage_emoji(source_file.covered_percent)} #{formatted_pct(source_file.covered_percent)} "\
        "| #{source_file.lines_of_code} "\
        "| #{source_file.covered_lines.size} "\
        "| #{source_file.covered_strength.round(1)} |"
      end

      def file_branch_columns(source_file)
        "#{coverage_emoji(source_file.branches_coverage_percent)} #{formatted_pct(source_file.branches_coverage_percent)} "\
        "| #{source_file.total_branches.count} "\
        "| #{source_file.covered_branches.count} "\
        "| #{source_file.missed_branches.count} |"
      end

      def formatted_pct(value)
        "#{value.round(1)}%"
      end

      def current_working_directory
        @current_working_directory ||= Dir.pwd
      end

      def filename(path)
        path.gsub(current_working_directory, '')
      end

      # Magic numbers copied from the http formatter
      # https://github.com/simplecov-ruby/simplecov-html/blob/79ddf6149ad9551587acca471b9af64a6bcac7cc/lib/simplecov-html.rb#L118
      def coverage_emoji(pct_coverage)
        if pct_coverage.to_i > 90
          ':green_heart:'
        elsif pct_coverage.to_i > 80
          ':warning:'
        else
          ':red_circle:'
        end
      end

      def covered_branches_percent
        100.0 * @result.covered_branches / @result.total_branches
      end

      def output_message
        "Markdown Coverage report generated for #{@result.command_name} to #{SimpleCov.coverage_path}. \
        #{@result.covered_lines} / #{@result.total_lines} LOC (#{@result.covered_percent.round(2)}%) covered."
      end
    end
  end
end
