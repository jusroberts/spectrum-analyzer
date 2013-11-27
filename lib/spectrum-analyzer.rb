require 'ruby-audio'
require 'fftw3'

require_relative '../lib/spectrum-analyzer/config'

Dir[File.dirname(__FILE__) + '/spectrum-analyzer/clients/*.rb'].each {| file| load file }
Dir[File.dirname(__FILE__) + '/spectrum-analyzer/criteria/*.rb'].each {| file| load file }

module SpectrumAnalyzer

  def self.configuration
    @configuration ||= SpectrumAnalyzer::Config.new()
  end

  def self.generate
    SpectrumAnalyzer::Generator.new()
  end

  def self.analyze
    SpectrumAnalyzer::Analyze
  end

  def self.quick_analyze
    SpectrumAnalyzer::Generator.quick_analyze
  end

  def self.file
    @file ||= SpectrumAnalyzer::File.new()
  end

  def self.spectrum
    @spectrum ||= SpectrumAnalyzer::Spectrum.new()
  end

end