module SpectrumAnalyzer
  class Generator
    def initialize
      @config = SpectrumAnalyzer.configuration
      @file = build_file_info
      @spectrum = SpectrumAnalyzer.spectrum
    end

    def set_file(file)
      @file = file
    end

    def quick_analyze
      #For each FFT window built
        #check for hit
          #return true if found
      #return false
    end

    def build_spectrum
      generate_spectrum()
      analyze_spectrum()
    end

    private


    def generate_spectrum
      #For each FFT window built
        #add FFT window to spectrum class
      begin
        buffer = RubyAudio::Buffer.float(@config.window_size)
        RubyAudio::Sound.open(@config.file_name) do |snd|
          while snd.read(buffer) != 0
            fft_slice = generate_domain(buffer)
            @spectrum.domains.push (SpectrumAnalyzer::Domain.new(fft_slice))
            #i=0
            #fft_slice.each { |x| spectrum[i] += x.magnitude; i+=1}
            #
            #spectrum_array[iterations] = fft_slice
            #i = 0
            #spectrum_array[iterations].each { |x| spectrum_array[iterations][i] = x.magnitude; i+=1}
            #iterations += 1
            #
            #ping = analyze_for_hit(fft_slice, iterations - 1)
            #return ping if ping
            #hits += 1 if ping
          end
        end

      rescue => err
        p "error reading audio file: " + err.to_s
        exit
      end
    end

    def generate_domain(buffer)
      wave = Array.new()
      windowed_array = apply_window(buffer.to_a, windows[@config.window_function])
      wave.concat(windowed_array)
      na = NArray.to_na(windowed_array)
      FFTW3.fft(na).to_a[0, @config.window_size/2]
    end

    def analyze_spectrum
      #for each FFT window in spectrum class
        #determine if window contains hit
          #apply hit bool to that fft object
      #sum all FFT windows in spectrum to create overall freq spectrum
      #return spectrum class
    end

    def build_file_info
      file = SpectrumAnalyzer::File.new(@config.file_name)
      file.sample_rate = RubyAudio::Sound.open(file.name).info.samplerate
      file
    end

    def windows
      {
          :hanning => hanning(@config.window_size),
          :rectangle => rectangle(@config.window_size)
      }
    end

    def gen_fft


      #p hits
      return false

    end


    def apply_window(buffer, window_type)
      windowed_array = Array.new()
      i=0
      buffer.each { |x| windowed_array[i] = x * window_type[i]; i+=1}
    end

    def hanning (window_size)
      hannified_array = Array.new
      i=0
      (0..window_size).each { |x| hannified_array[i] = 0.5 - 0.5 * Math.cos(2 * Math::PI * i / window_size) ; i+=1}

      hannified_array
    end

    def rectangle (window_size)
      Array.new(window_size, 1)
    end

    def analysis_array
      @config.analysis_array
    end

    def analyze_for_hit(fft_array, index)
      #ranges = analysis_array
      #
      #j=0
      #hit = Array.new()
      ##p "INDEX: #{index}"
      #ranges.each do |x|
      #  sum_total = 0
      #  for i in x[:b_index]..x[:t_index]
      #    sum_total += fft_array[i] if !fft_array[i].nil?
      #  end
      #  average = sum_total / (x[:t_index] - x[:b_index])
      #  hit[j] = average > x[:min] and average < x[:max]
      #  j+=1
      #end
      #ping = !hit.include?(false)
      #return ping
    end

  end
end


