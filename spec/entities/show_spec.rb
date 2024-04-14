# spec/show_spec.rb

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
end
