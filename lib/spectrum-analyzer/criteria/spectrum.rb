module SpectrumAnalyzer
  class Spectrum
    attr_accessor :spectrum

    def initialize(spectrum)
      @spectrum = spectrum || []
    end
  end
end