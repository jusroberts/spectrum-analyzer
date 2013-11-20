module SpectrumAnalyzer
  class Generator
    def initialize
      @file = SpectrumAnalyzer.configuration.file_name
    end

    def quick_analyze

    end

    def self.gen_fft
      fname = @file
      window_size = 512
      wave = Array.new
      spectrum = Array.new(window_size/2,0)
      hanning_window = hanning(window_size)
      iterations = 0
      spectrum_array = Array.new()
      hits = 0
      begin
        buf = RubyAudio::Buffer.float(window_size)
        RubyAudio::Sound.open(fname) do |snd|
          samplerate = snd.info.samplerate
          while snd.read(buf) != 0
            windowed_array = apply_window(buf.to_a, hanning_window)
            wave.concat(windowed_array)
            na = NArray.to_na(windowed_array)
            fft_slice = FFTW3.fft(na).to_a[0, window_size/2]
            i=0
            fft_slice.each { |x| spectrum[i] += x.magnitude; i+=1}

            spectrum_array[iterations] = fft_slice
            i = 0
            spectrum_array[iterations].each { |x| spectrum_array[iterations][i] = x.magnitude; i+=1}
            iterations += 1

            ping = analyze_for_hit(fft_slice, iterations - 1)
            return ping if ping
            #hits += 1 if ping
          end
        end

      rescue => err
        p "error reading audio file: " + err.to_s
        exit
      end

      #p hits
      return false

    end


    private

    def self.apply_window(buffer, window_type)
      windowed_array = Array.new()
      i=0
      buffer.each { |x| windowed_array[i] = x * window_type[i]; i+=1}
    end

    def self.hanning (window_size)
      hannified_array = Array.new
      i=0
      (0..window_size).each { |x| hannified_array[i] = 0.5 - 0.5 * Math.cos(2 * Math::PI * i / window_size) ; i+=1}

      hannified_array
    end

    def self.analyze_for_hit(fft_array, index)
      ranges = [{ :b_index => 27, :t_index => 47,   :min => 1,    :max => 2},     #Low area
                { :b_index => 58, :t_index => 64,   :min => 2.5,  :max => 6.5},   #High peak
                { :b_index => 70, :t_index => 74,   :min => 2.0,  :max => 4.2 },  #Mid peak
                { :b_index => 82, :t_index => 109,  :min => 0.8,  :max => 2}      #Low area
      ]

      j=0
      hit = Array.new()
      #p "INDEX: #{index}"
      ranges.each do |x|
        sum_total = 0
        for i in x[:b_index]..x[:t_index]
          sum_total += fft_array[i] if !fft_array[i].nil?
        end
        average = sum_total / (x[:t_index] - x[:b_index])
        hit[j] = average > x[:min] and average < x[:max]
        #p x[:b_index]
        #p average
        #p hit[j]
        j+=1
      end
      ping = !hit.include?(false)
      #p "INDEX: #{index}" if ping
      #p ping if ping
      #p ping
      return ping
    end

  end
end


