module SpectrumAnalyzer
  class WindowFunctions
    def initialize(window_size)
      @window_size = window_size
    end
    def hanning
      hannified_array = Array.new
      i=0
      (0..@window_size).each { |x| hannified_array[i] = 0.5 - 0.5 * Math.cos(2 * Math::PI * i / @window_size) ; i+=1}

      hannified_array
    end

    def rectangle
      Array.new(@window_size, 1)
    end

  end
end