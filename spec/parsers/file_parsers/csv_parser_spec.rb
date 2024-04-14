require './lib/parsers/file_parsers/csv_parser'

RSpec.describe FileParser::CSVParser do
  describe '.load' do
    let(:file_path) { 'spec/fixtures/movies.csv' }

    it 'parses the CSV file and yields each row to the provided block' do
      data = described_class.load(file_path) do |row|
        {
          title: row['title'],
          genre: row['genre'],
          total_capacity: row['totalcapacity'].to_i,
          show_times: row['showtimes'].split(',').map(&:strip)
        }
      end

      expect(data).to be_an(Array)
      expect(data.length).to eq(4)

      expect(data[0]).to include(
        title: 'The Matrix',
        genre: 'Sci-Fi',
        total_capacity: 100,
        show_times: ['2024-04-15 20:00:00', '2024-04-16 18:00:00']
      )
    end
  end
end
