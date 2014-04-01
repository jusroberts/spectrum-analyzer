module SpectrumAnalyzer
  module Functions
    class Generator
      
      def initialize
        @config = SpectrumAnalyzer.configuration
        @window_functions = SpectrumAnalyzer::WindowFunctions.new(@config.window_size)
        @analysis = SpectrumAnalyzer::Objects::Analysis.new(@config.file_name)
      end

      #rename to contains_frequency_range?
      def quick_analyze
        begin
          buffer = RubyAudio::Buffer.float(@config.window_size)
          RubyAudio::Sound.open(@config.file_name) do |snd|
            while snd.read(buffer) != 0
              return true if quick_analyze_buffer(buffer)
            end
          end
  
        rescue => err
          error(err)
        end
      end
  
      def analyze
        generate_spectrum()
        analyze_spectrum()
        return @analysis
      end
  
      private

      def quick_analyze_buffer(buffer)
        return true if domain_contains_frequencies?(generate_domain(buffer))
      end

      def generate_domain(buffer)
        windowed_buffer = apply_window(buffer.to_a, windows[@config.window_function])
        SpectrumAnalyzer::Objects::Domain.new(windowed_buffer)
      end

      def domain_contains_frequencies?(domain)
        domain.contains_frequencies?(@config.analysis_ranges)
      end

      def generate_spectrum
        begin
          buffer = RubyAudio::Buffer.float(@config.window_size)
          RubyAudio::Sound.open(@config.file_name) do |snd|
            while snd.read(buffer) != 0
              windowed_buffer = apply_window(buffer.to_a, windows[@config.window_function])
              @analysis.add_domain_to_spectrum(windowed_buffer)
            end
          end
  
        rescue => err
          error(err)
        end
      end

      #this should be a function in spectrum class
      def sum_domains
        @analysis.sum_spectrum
      end

      def analyze_spectrum
        sum_domains
        find_occurrences
      end

      def find_occurrences
        @analysis.sum_occurrences
      end
  
      def windows
        @window_functions.windows()
      end
  
      def apply_window(buffer, window_type)
        windowed_array = Array.new()
        i=0
        buffer.each { |x| windowed_array[i] = x * window_type[i]; i+=1}
      end

      def error(err)
        raise StandardError, err
      end
  
    end
  end
end



