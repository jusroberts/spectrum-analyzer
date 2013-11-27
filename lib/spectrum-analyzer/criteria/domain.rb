module SpectrumAnalyzer
  class Domain
    attr_accessor :values, :contains_frequency_range

    def initialize(values)
      @values = values
    end
  end
end