# frozen_string_literal: true

require 'singleton'
require 'tty-prompt'

require_relative 'parsers/file_parser'
require_relative 'services/movies_importer_service'
require_relative 'services/book_ticket_service'
require_relative 'helpers/user_interface'
require_relative 'services/cancel_ticket_service'

# The class is the main entry point of the application.
class MovieBookingApp
  include Singleton

  MOVIES_FILE_PATH = 'data/movies.csv'

  def run
    setup
    UserInterface.new(app_container: self).call
  end

  def book_ticket(show)
    result = BookTicketService.call(show: show)
    tickets << result[:ticket] if result[:success]

    result
  end

  def cancel_ticket(ticket)
    CancelTicketService.call(ticket: ticket)
  end

  def prompt
    @prompt ||= TTY::Prompt.new(interrupt: :exit, active_color: :cyan)
  end

  def movies
    @movies ||= []
  end

  def tickets
    @tickets ||= []
  end

  private

  def setup
    @movies = MoviesImporterService.import(MOVIES_FILE_PATH)
  rescue StandardError => e
    prompt.error("Failed importing movies: #{e.message}")
    abort('Exiting...')
  end
end
