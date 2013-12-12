require 'ruby-audio'
require 'fftw3'

#require_relative '../lib/spectrum-analyzer/config'

Dir[File.dirname(__FILE__) + '/spectrum-analyzer/*.rb'].each {| file| load file }
Dir[File.dirname(__FILE__) + '/spectrum-analyzer/functions/*.rb'].each {| file| load file }
Dir[File.dirname(__FILE__) + '/spectrum-analyzer/objects/*.rb'].each {| file| load file }

module SpectrumAnalyzer
  attr_accessor :analysis

  def self.configuration(args = {})
    @configuration ||= SpectrumAnalyzer::Config.new(args)
  end

  def self.analyze
    configuration
    SpectrumAnalyzer::Functions.analyze
  end

  def self.quick_analyze
    configuration
    SpectrumAnalyzer::Functions.quick_analyze
  end

end