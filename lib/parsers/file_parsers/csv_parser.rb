# frozen_string_literal: true

require 'csv'

module FileParser
  # This module provides a CSV parser.
  module CSVParser
    def self.load(file_path, &block)
      data = []

      CSV.foreach(file_path, headers: true) do |row|
        entry = block.call(row)
        data << entry
      end

      data
    end
  end
end
