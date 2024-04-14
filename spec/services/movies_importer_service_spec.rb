require './lib/services/movies_importer_service'

RSpec.describe MoviesImporterService do
  describe '.import' do
    let(:file_path) { 'spec/fixtures/movies.csv' }

    context 'when importing movies from a CSV file' do
      it 'loads movies from the file and creates movie objects with shows' do
        movies = described_class.import(file_path)
        first_movie = movies.first
        first_show = first_movie.shows.first

        expect(movies).to be_an(Array)
        expect(movies.length).to eq(4)

        expect(first_movie).to be_an_instance_of(Movie)
        expect(first_movie.title).to be_a(String)
        expect(first_movie.genre).to be_a(String)
        expect(first_movie.shows).to be_an(Array)
        expect(first_movie.shows.length).to eq(2)

        expect(first_show).to be_an_instance_of(Show)
        expect(first_show.movie).to eq(first_movie)
        expect(first_show.show_time).to be_a(Time)
        expect(first_show.total_capacity).to be_an(Integer)
        expect(first_show.available_seats).to be_an(Array)
      end
    end
  end
end
