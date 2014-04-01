module SpectrumAnalyzer
  module Objects
    class Domain
      attr_accessor :values, :raw_values, :contains_frequency_range

      def initialize(buffer)
        @config = SpectrumAnalyzer.configuration
        @values = []
        @raw_values = []
        @contains_frequency_range = false
        analyze_buffer(buffer)

      end

      def analyze_buffer(buffer)
        fft_array = fft_array_builder(buffer)
        fft_array.each { |x| @raw_values.push(x); @values.push(x.magnitude)}
      end


      def contains_frequencies?(frequency_ranges)
        j=0
        match = Array.new()
        frequency_ranges.each do |range|
          sum_total = 0
          for i in range[:b_index]..range[:t_index]
            sum_total += values[i] unless values[i].nil?
          end
          average = sum_total / (range[:t_index] - range[:b_index])
          match[j] = average > range[:min] and average < range[:max]
          j+=1
        end
        return !match.include?(false)
      end

      private

      def fft_array_builder(windowed_buffer)
        na = NArray.to_na(windowed_buffer)
        FFTW3.fft(na).to_a[0, @config.window_size/2]
      end
    end
  end
end
