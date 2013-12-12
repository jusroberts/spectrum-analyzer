module SpectrumAnalyzer
  module Functions

    def self.analyze
      SpectrumAnalyzer::Functions::Generator.new().analyze
    end

    def self.quick_analyze
      SpectrumAnalyzer::Functions::Generator.new().quick_analyze
    end

  end
end