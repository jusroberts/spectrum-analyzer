module SpectrumAnalyzer
  class Spectrum
    attr_accessor :domains, :entire_spectrum, :num_occurrences

    def initialize(spectrum = [])
      @domains = spectrum
    end
  end
end