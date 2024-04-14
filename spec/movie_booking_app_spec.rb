# spec/movie_booking_app_spec.rb

require './lib/movie_booking_app'
require './lib/services/movies_importer_service'

RSpec.describe MovieBookingApp do
  subject { described_class.instance }

  describe '#run' do
    it 'calls MoviesImporterService.import with MOVIES_FILE_PATH' do
      expect(MoviesImporterService).to receive(:import).with(MovieBookingApp::MOVIES_FILE_PATH)
      subject.run
    end
  end

  describe '#prompt' do
    it 'returns an instance of TTY::Prompt' do
      expect(subject.prompt).to be_an_instance_of(TTY::Prompt)
    end

    it 'returns the same instance on subsequent calls' do
      prompt1 = subject.prompt
      prompt2 = subject.prompt
      expect(prompt1).to eq(prompt2)
    end
  end

  describe '#movies' do
    it 'returns an array' do
      expect(subject.movies).to be_an(Array)
    end

    it 'returns an empty array by default' do
      expect(subject.movies).to be_empty
    end
  end

  describe '#tickets' do
    it 'returns an array' do
      expect(subject.tickets).to be_an(Array)
    end

    it 'returns an empty array by default' do
      expect(subject.tickets).to be_empty
    end
  end

  describe '#book_ticket' do
    let(:show) { instance_double('Show') }
    let(:ticket) { instance_double('Ticket') }
    let(:success_result) { { success: true, ticket: ticket, message: '🎉 Ticket booked successfully! 🎉' } }

    before do
      allow(BookTicketService).to receive(:call).with(show: show).and_return(success_result)
    end

    it 'calls BookTicketService and adds the ticket to the list of tickets if booking is successful' do
      subject.book_ticket(show)
      expect(BookTicketService).to have_received(:call).with(show: show)
      expect(subject.tickets).to contain_exactly(ticket)
    end
  end

  describe '#cancel_ticket' do
    let(:ticket) { instance_double('Ticket') }
    let(:success_result) { { success: true, message: '🎉 Ticket canceled successfully 🎉' } }

    before do
      allow(subject).to receive(:tickets).and_return([ticket])
      allow(CancelTicketService).to receive(:call).with(ticket: ticket).and_return(success_result)
    end

    it 'calls CancelTicketService' do
      result = subject.cancel_ticket(ticket)

      expect(CancelTicketService).to have_received(:call).with(ticket: ticket)
      expect(result[:success]).to be_truthy
      expect(result[:message]).to eq('🎉 Ticket canceled successfully 🎉')
    end
  end
end
