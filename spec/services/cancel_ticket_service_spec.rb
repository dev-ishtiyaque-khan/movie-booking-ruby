require './lib/services/cancel_ticket_service'
require './lib/entities/ticket'
require './lib/entities/show'

RSpec.describe CancelTicketService do
  describe '.call' do
    let(:ticket) { instance_double('Ticket', canceled?: false, cancel_ticket!: nil, show: show, seat_number: 'A1') }
    let(:show) { instance_double('Show', release_seat: nil) }

    context 'when the ticket is not already canceled' do
      it 'cancels the ticket and releases the seat' do
        result = described_class.call(ticket: ticket)
        expect(ticket).to have_received(:cancel_ticket!)
        expect(show).to have_received(:release_seat).with('A1')
        expect(result[:success]).to be_truthy
        expect(result[:message]).to eq '🎉 Ticket canceled successfully 🎉'
      end
    end

    context 'when the ticket is already canceled' do
      before { allow(ticket).to receive(:canceled?).and_return(true) }

      it 'does not cancel the ticket and returns an error message' do
        result = described_class.call(ticket: ticket)

        expect(ticket).not_to have_received(:cancel_ticket!)
        expect(show).not_to have_received(:release_seat)
        expect(result[:success]).to be_falsey
        expect(result[:message]).to eq 'Ticket already canceled'
      end
    end
  end
end
