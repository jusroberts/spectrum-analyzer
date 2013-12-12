module SpectrumAnalyzer
  module Objects
    class Analysis
      attr_accessor :file, :spectrum

      def initialize(file_name)
        @spectrum = SpectrumAnalyzer::Objects::Spectrum.new()
        @file = SpectrumAnalyzer::Objects::File.new(file_name)
      end

    end
  end
end