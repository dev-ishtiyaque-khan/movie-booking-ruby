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
end
