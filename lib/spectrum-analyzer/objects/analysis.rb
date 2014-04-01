module SpectrumAnalyzer
  module Objects
    class Analysis
      attr_accessor :file, :spectrum

      def initialize(file_name)
        @spectrum = SpectrumAnalyzer::Objects::Spectrum.new()
        @file = SpectrumAnalyzer::Objects::File.new(file_name)
      end

      def sum_spectrum
        @spectrum.sum_domains
      end

      def sum_occurrences
        @spectrum.sum_occurrences
      end

      def add_domain_to_spectrum(buffer)
        @spectrum.add_domain(buffer)
      end

    end
  end
end