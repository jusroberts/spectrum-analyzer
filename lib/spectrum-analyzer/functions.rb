module SpectrumAnalyzer
  module Functions

    def self.analyze
      SpectrumAnalyzer::Functions::Generator.new().analyze
    end

    def self.quick_analyze
      SpectrumAnalyzer::Functions::Generator.new().quick_analyze
    end

    def self.contains_frequency_range?
      SpectrumAnalyzer::Functions::Generator.new().contains_frequency_range?
    end

  end
end