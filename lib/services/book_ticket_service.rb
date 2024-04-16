# frozen_string_literal: true

require_relative '../entities/ticket'

# This service is responsible to book a ticket for a show.
class BookTicketService
  NO_SEATS_ERROR_MESSAGE = 'No seats available for %s show'

  def self.call(show:)
    return { success: false, message: NO_SEATS_ERROR_MESSAGE % show.movie_title } unless show.seat_available?

    seat_number = show.random_available_seat
    ticket = Ticket.new(show, seat_number)

    show.reserve_seat(seat_number)

    { success: true, ticket:, message: '🎉 Ticket booked successfully! 🎉' }
  end
end
