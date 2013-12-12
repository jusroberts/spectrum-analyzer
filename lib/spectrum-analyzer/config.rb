module SpectrumAnalyzer
  class Config
    attr_accessor :file_name, :window_function, :window_size, :analysis_ranges

    def initialize(args = {})
      @window_size        = args[:window_size]     || 1024
      @window_function    = args[:window_function] || :hanning
      @analysis_ranges    = args[:analysis_ranges] || []
      @file_name          = args[:file_name]       || ""
    end

  end
end