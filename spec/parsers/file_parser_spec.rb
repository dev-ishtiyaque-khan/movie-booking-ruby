# spec/file_parser_spec.rb

require './lib/parsers/file_parser'

RSpec.describe FileParser do
  describe '.load' do
    context 'when loading a supported CSV file' do
      let(:csv_file_path) { 'spec/fixtures/movies.csv' }

      it 'calls CSVParser.load with the file path and provided block' do
        expect(FileParser::CSVParser).to receive(:load).with(csv_file_path)

        FileParser.load(csv_file_path)
      end
    end

    context 'when loading an unsupported file format' do
      let(:unsupported_file_path) { 'spec/fixtures/unsupported.txt' }

      it 'raises UnsupportedFormatError' do
        expect {
          FileParser.load(unsupported_file_path)
        }.to raise_error(FileParser::UnsupportedFormatError, 'Unsupported file format: .txt')
      end
    end
  end
end
