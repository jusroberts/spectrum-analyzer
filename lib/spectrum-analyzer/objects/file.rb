module SpectrumAnalyzer
  module Objects
    class File
      attr_accessor :name, :sample_rate

      def initialize(name)
        @name = name || ''
        @sample_rate = RubyAudio::Sound.open(name).info.samplerate
      end

      def read

      end
    end
  end
end
