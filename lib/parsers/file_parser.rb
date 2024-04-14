# frozen_string_literal: true

require_relative 'file_parsers/csv_parser'

# This module provides a way to load files in different formats.
module FileParser
  class UnsupportedFormatError < StandardError; end

  def self.load(file_path, &block)
    extension = File.extname(file_path).downcase
    parser_class_name = "#{extension[1..].upcase}Parser"

    unless FileParser.const_defined?(parser_class_name)
      raise UnsupportedFormatError, "Unsupported file format: #{extension}"
    end

    parser_class = FileParser.const_get(parser_class_name)
    parser_class.load(file_path, &block)
  end
end
