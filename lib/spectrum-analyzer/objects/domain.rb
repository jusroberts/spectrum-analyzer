module SpectrumAnalyzer
  module Objects
    class Domain
      attr_accessor :values, :raw_values, :contains_frequency_range

      def initialize()
        @values = []
        @raw_values = []
        @contains_frequency_range = false
      end

    end
  end
end
