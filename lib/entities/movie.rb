# frozen_string_literal: true

# Represents a Movie with a title and genre.
class Movie
  attr_reader :title, :genre, :shows

  def initialize(title:, genre:)
    @title = title
    @genre = genre
    @shows = []
  end

  def add_show(show)
    shows << show
  end

  def to_s
    "#{title} (#{genre})"
  end
end
