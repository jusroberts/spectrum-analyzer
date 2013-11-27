module SpectrumAnalyzer
  class File
    attr_accessor :name, :sample_rate

    def initialize(name)
      @name = name || ''
    end

    def read

    end
  end
end