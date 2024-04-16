# spec/book_ticket_service_spec.rb

require './lib/services/book_ticket_service'
require './lib/entities/show'
require './lib/entities/ticket'

RSpec.describe BookTicketService, :verify_partial_doubles do
  let(:show) { instance_double('Show', movie_title: 'The Matrix') }
  let(:ticket) { instance_double('Ticket', show: show, seat_number: 'A1') }

  describe '.call' do
    before do
      allow(show).to receive(:reserve_seat).with('A1')
      allow(Ticket).to receive(:new).and_return(ticket)
    end
  
    context 'when there are available seats' do
      before do
        allow(show).to receive(:seat_available?).and_return(true)
        allow(show).to receive(:random_available_seat).and_return('A1')
      end

      it 'books a ticket successfully' do
        result = described_class.call(show: show)

        expect(show).to have_received(:reserve_seat).with('A1')
        expect(result[:success]).to be_truthy
        expect(result[:ticket].seat_number).to eql('A1')
        expect(result[:message]).to eq('🎉 Ticket booked successfully! 🎉')
      end
    end

    context 'when there are no available seats' do
      before { allow(show).to receive(:seat_available?).and_return(false) }

      it 'returns a failure message' do
        expect(described_class.call(show: show))
          .to eq({ success: false, message: 'No seats available for The Matrix show' })
      end
    end
  end
end
