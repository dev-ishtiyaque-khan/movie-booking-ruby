# frozen_string_literal: true

require 'time'
require 'forwardable'

# Represents a Show with a movie, show time, and total capacity.
class Show
  extend Forwardable

  MAX_SEATS_PER_ROW = 10
  SEAT_ROWS = ('A'..'Z').to_a

  attr_reader :movie, :show_time, :total_capacity, :available_seats

  def_delegator :@movie, :title, :movie_title
  def_delegator :@movie, :genre, :movie_genre

  def initialize(movie:, show_time:, total_capacity:)
    @movie = movie
    @show_time = Time.parse(show_time)
    @total_capacity = total_capacity
    @available_seats = generate_seats(total_capacity)
  end

  def reserve_seat(seat_number)
    available_seats.delete(seat_number)
  end

  def seat_available?
    !available_seats.empty?
  end

  def random_available_seat
    available_seats.sample
  end

  def to_s
    "#{formatted_show_time} (#{total_available_seats})"
  end

  def total_available_seats
    available_seats.length
  end

  def formatted_show_time
    show_time.strftime('%I:%M %p')
  end

  private

  def generate_seats(total_capacity)
    seats = []

    SEAT_ROWS.each do |row|
      1.upto(MAX_SEATS_PER_ROW) do |number|
        seat = "#{row}#{number}"
        seats << seat
        break if seats.length == total_capacity
      end
      break if seats.length == total_capacity
    end

    seats
  end
end
