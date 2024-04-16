# frozen_string_literal: true

require './lib/entities/movie'
require './lib/entities/show'

RSpec.describe Show do
  let(:movie) { instance_double('Movie', title: 'The Matrix', genre: 'Sci-Fi') }
  let(:show_time) { '2024-04-15 20:00:00' }
  let(:total_capacity) { 50 }

  subject(:show) { described_class.new(movie: movie, show_time: show_time, total_capacity: total_capacity) }

  describe '#to_s' do
    it 'returns a string representation of the show' do
      expect(show.to_s).to eq('08:00 PM (50)')
    end
  end

  describe '#total_available_seats' do
    it 'returns the total number of available seats' do
      expect(show.total_available_seats).to eq(total_capacity)
    end
  end

  describe '#formatted_show_time' do
    it 'returns the formatted show time' do
      expect(show.formatted_show_time).to eq('08:00 PM')
    end
  end

  describe '#movie_title' do
    it 'returns the title of the associated movie' do
      expect(show.movie_title).to eq('The Matrix')
    end
  end

  describe '#movie_genre' do
    it 'returns the genre of the associated movie' do
      expect(show.movie_genre).to eq('Sci-Fi')
    end
  end

  describe '#reserve_seat' do
    let(:seat_number) { 'A1' }
    let(:seat_numbers) { ['A1', 'A2', 'A3'] }

    before { allow(show).to receive(:available_seats).and_return(seat_numbers) }

    it 'removes the reserved seat from available seats' do
      show.reserve_seat(seat_number)
      expect(show.available_seats).to_not include(seat_number)
    end
  end

  describe '#seat_available?' do
    context 'when available seats are empty' do
      before { allow(show).to receive(:available_seats).and_return([]) }

      it 'returns false' do
        expect(show.seat_available?).to be false
      end
    end

    context 'when available seats are not empty' do
      before { allow(show).to receive(:available_seats).and_return(['A1']) }

      it 'returns true' do
        expect(show.seat_available?).to be true
      end
    end
  end

  describe '#random_available_seat' do
    let(:seat_numbers) { ['A1', 'A2', 'A3'] }

    before { allow(show).to receive(:available_seats).and_return(seat_numbers) }

    it 'returns a random available seat' do
      random_seat = show.random_available_seat
      expect(seat_numbers).to include(random_seat)
    end
  end

  describe '#release_seat' do
    let(:show) { described_class.new(movie: double('Movie'), show_time: show_time, total_capacity: 100) }

    context 'when the seat is not already released' do
      before { allow(show).to receive(:available_seats).and_return(['A1', 'A2', 'B1', 'B2']) }

      it 'releases the seat and sorts available seats' do
        show.release_seat('B1')
        expect(show.available_seats).to eq(['A1', 'A2', 'B1', 'B2'])
      end
    end

    context 'when the seat is already released' do
      before { allow(show).to receive(:available_seats).and_return(['A1', 'A2', 'B1', 'C1', 'B2']) }

      it 'does not add the seat again' do
        show.release_seat('C1')
        expect(show.available_seats).to eq(['A1', 'A2', 'B1', 'C1', 'B2'])
      end
    end
  end
end
