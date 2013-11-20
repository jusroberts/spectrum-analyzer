module SpectrumAnalyzer
  class File
    attr_accessor :name, :recording_frequency

    def initialize(name)
      @name = name || ''
    end

    def read

    end
  end
end