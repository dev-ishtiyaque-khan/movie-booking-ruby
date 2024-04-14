require './lib/entities/movie'

RSpec.describe Movie do
  subject(:movie) { described_class.new(title: 'The Matrix', genre: 'Sci-Fi') }

  describe '#add_show' do
    let(:show) { instance_double('Show') }

    it 'adds a show to the movie' do
      expect { movie.add_show(show) }.to change { movie.shows.length }.by(1)
    end
  end

  describe '#to_s' do
    it 'returns a string representation of the movie' do
      expect(movie.to_s).to eq('The Matrix (Sci-Fi)')
    end
  end
end
