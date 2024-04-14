require './lib/entities/ticket'
require './lib/entities/show'

RSpec.describe Ticket do
  subject { described_class.new(show, seat_number) }

  let(:show) { instance_double('Show', movie_title: 'The Matrix', formatted_show_time: '2024-04-15 20:00:00') }
  let(:seat_number) { 'A1' }

  describe '#to_s' do
    it 'returns a string representation of the ticket' do
      expect(subject.to_s).to eq('[Booked] The Matrix 2024-04-15 20:00:00 (A1)')
    end
  end

  describe '#cancel_ticket!' do
    it 'cancels the ticket' do
      subject.cancel_ticket!
      expect(subject.status).to eq(described_class::TICKET_CANCELED)
    end
  end

  describe '#booked?' do
    it 'returns true if the ticket is booked' do
      expect(subject.booked?).to be_truthy
    end
  end

  describe '#canceled?' do
    it 'returns true if the ticket is canceled' do
      subject.cancel_ticket!

      expect(subject.canceled?).to be_truthy
    end
  end
end
