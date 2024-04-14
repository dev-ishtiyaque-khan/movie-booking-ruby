# frozen_string_literal: true

require 'singleton'
require 'tty-prompt'

require_relative 'parsers/file_parser'
require_relative 'services/movies_importer_service'

# The class is the main entry point of the application.
class MovieBookingApp
  include Singleton

  MOVIES_FILE_PATH = 'data/movies.csv'

  def run
    setup
  end

  def prompt
    @prompt ||= TTY::Prompt.new(interrupt: :exit, active_color: :cyan)
  end

  def movies
    @movies ||= []
  end

  private

  def setup
    @movies = MoviesImporterService.import(MOVIES_FILE_PATH)
  rescue StandardError => e
    prompt.error("Failed importing movies: #{e.message}")
    abort('Exiting...')
  end
end
