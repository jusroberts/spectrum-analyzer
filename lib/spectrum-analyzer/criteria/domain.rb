module SpectrumAnalyzer
  class Domain
    attr_accessor :values, :raw_values, :contains_frequency_range

    def initialize()
      @values = []
      @raw_values = []
    end
  end
end