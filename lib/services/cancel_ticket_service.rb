# frozen_string_literal: true

require_relative '../entities/ticket'

# This service is responsible for canceling a ticket.
class CancelTicketService
  ALREADY_CANCELED_ERROR_MESSAGE = 'Ticket already canceled'

  def self.call(ticket:)
    return { success: false, message: ALREADY_CANCELED_ERROR_MESSAGE } if ticket.canceled?

    ticket.cancel_ticket!
    ticket.show.release_seat(ticket.seat_number)

    { success: true, message: '🎉 Ticket canceled successfully 🎉' }
  end
end
