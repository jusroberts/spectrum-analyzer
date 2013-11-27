module SpectrumAnalyzer
  class Spectrum
    attr_accessor :domains, :entire_spectrum

    def initialize(spectrum = [])
      @domains = spectrum
    end
  end
end