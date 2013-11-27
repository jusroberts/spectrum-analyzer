module SpectrumAnalyzer
  class Config
    attr_accessor :file_name, :window_function, :window_size, :analysis_range

    def initialize
      @window_size        = 512
      @window_function    = :hanning
      @analysis_array     = [{ :b_index => 27, :t_index => 47,   :min => 1,    :max => 2},     #Low area
                             { :b_index => 58, :t_index => 64,   :min => 2.5,  :max => 6.5},   #High peak
                             { :b_index => 70, :t_index => 74,   :min => 2.0,  :max => 4.2 },  #Mid peak
                             { :b_index => 82, :t_index => 109,  :min => 0.8,  :max => 2}]     #Low area
      @file_name          = "spec/analyze.wav"
    end

  end



end