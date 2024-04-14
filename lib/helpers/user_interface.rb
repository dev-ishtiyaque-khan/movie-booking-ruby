# frozen_string_literal: true

require 'tty-prompt'

# This class is responsible for handling user input and displaying output to the user.
class UserInterface
  USER_OPTIONS = {
    'Book Ticket' => :book_ticket,
    'Cancel Ticket' => :cancel_ticket,
    'View Tickets' => :view_tickets,
    'Exit' => :exit
  }.freeze

  attr_reader :app_container

  def initialize(app_container:)
    @app_container = app_container
  end

  def call
    prompt.say('🔥 Welcome to Movie Booking App! 🔥')
    prompt.say('-----------------------------')
    loop do
      choice = prompt.select('Choose what you would like to do:', USER_OPTIONS, cycle: true)
      next send(choice) unless choice.eql?(:exit)

      prompt.ok('🔥 Thanks for using Movie Booking App! 🔥')
      abort('Exiting...')
    end
  end

  private

  def book_ticket
    loop do
      selected_movie = select_movie
      break if selected_movie.eql?(:go_back)

      selected_show = select_show(selected_movie)
      next if selected_show.eql?(:go_back)

      book_ticket_for_show(selected_show)
      break
    end
  end

  def cancel_ticket
    booked_tickets = app_container.tickets.select(&:booked?)
    return prompt.warn('🎫 No tickets booked yet') if booked_tickets.empty?

    options = build_user_options(booked_tickets)
    selected_ticket = prompt.select('Cancel ticket:', options, per_page: 10, cycle: true)
    return if selected_ticket.eql?(:go_back)

    perform_ticket_cancellation(selected_ticket)
  end

  def view_tickets
    tickets = app_container.tickets
    return prompt.warn('🎫 You have no booked or canceled tickets') if tickets.empty?

    tickets.each do |ticket|
      ticket_details = ticket.to_s

      if ticket.booked?
        prompt.ok(ticket_details)
      else
        prompt.warn(ticket_details)
      end
    end
  end

  def select_movie
    options = build_user_options(app_container.movies)
    prompt.select('Choose a movie:', options, per_page: 10, cycle: true)
  end

  def select_show(movie)
    options = build_user_options(movie.shows) do |show|
      { name: show.to_s, value: show, disabled: !show.seat_available? && '🚫 Sold Out' }
    end
    prompt.select("Select a show to book for #{movie.title}?", options, per_page: 10, cycle: true)
  end

  def book_ticket_for_show(show)
    return if prompt.no?('Are you sure you want to book this ticket?')

    result = app_container.book_ticket(show)
    return prompt.error(result[:message]) unless result[:success]

    prompt.ok(result[:message])
    prompt.ok(result[:ticket].to_s)
  end

  def perform_ticket_cancellation(ticket)
    return if prompt.no?('Are you sure you want to cancel this ticket?')

    result = app_container.cancel_ticket(ticket)
    return prompt.ok(result[:message]) if result[:success]

    prompt.error(result[:message])
  end

  def build_user_options(data, &block)
    options = [{ name: 'Go Back', value: :go_back }]

    data.each do |item|
      item = if block_given?
        block.call(item)
      else
        { name: item.to_s, value: item }
      end
      options.unshift(item)
    end

    options
  end

  def prompt
    app_container.prompt
  end
end
