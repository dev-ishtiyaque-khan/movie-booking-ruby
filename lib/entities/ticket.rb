# frozen_string_literal: true

# Represents a ticket with a show and seat number.
class Ticket
  attr_reader :id, :show, :seat_number
  attr_accessor :status

  TICKET_STATUSES = [
    TICKET_BOOKED = 'Booked',
    TICKET_CANCELED = 'Canceled'
  ].freeze

  def initialize(show, seat_number)
    @id = generate_id
    @show = show
    @seat_number = seat_number
    @status = TICKET_BOOKED
  end

  TICKET_STATUSES.each do |status|
    define_method("#{status.downcase}?") { self.status == status }
  end

  def to_s
    "#{id}: [#{status}] #{show.movie_title} #{show.formatted_show_time} (#{seat_number})"
  end

  def cancel_ticket!
    self.status = TICKET_CANCELED
  end

  private

  def generate_id
    (Time.now.to_i + rand(1000..10_000_000))
  end
end
