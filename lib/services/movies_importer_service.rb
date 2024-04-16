# frozen_string_literal: true

require_relative '../parsers/file_parser'
require_relative '../entities/movie'
require_relative '../entities/show'

# This service is responsible for importing movies from a given file.
class MoviesImporterService
  def self.import(file_path)
    FileParser.load(file_path) do |row|
      show_times = row['showtimes'].split(',').map(&:strip)

      movie = Movie.new(title: row['title'], genre: row['genre'])

      show_times.each do |show_time|
        show = Show.new(movie:, show_time:, total_capacity: row['totalcapacity'].to_i)
        movie.add_show(show)
      end

      movie
    end
  end
end
