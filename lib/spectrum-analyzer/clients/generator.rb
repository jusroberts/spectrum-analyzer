module SpectrumAnalyzer
  class Generator
    def initialize
      @config = SpectrumAnalyzer.configuration
      @file = build_file_info
      @spectrum = SpectrumAnalyzer.spectrum
      @window_functions = SpectrumAnalyzer::WindowFunctions.new(@config.window_size)
    end

    def set_file(file)
      @file = file
    end

    def quick_analyze
      begin
        buffer = RubyAudio::Buffer.float(@config.window_size)
        RubyAudio::Sound.open(@config.file_name) do |snd|
          while snd.read(buffer) != 0
            domain = generate_domain(buffer)
            return true if domain_contains_frequencies?(domain)
          end
        end

      rescue => error
        p "Error: " + error.to_s
        exit
      end
    end

    def build_spectrum
      generate_spectrum()
      analyze_spectrum()
    end

    private

    def domain_contains_frequencies?(domain)
      j=0
      match = Array.new()
      @config.analysis_ranges.each do |range|
        sum_total = 0
        for i in range[:b_index]..range[:t_index]
          sum_total += domain.values[i] if !domain.values[i].nil?
        end
        average = sum_total / (range[:t_index] - range[:b_index])
        match[j] = average > range[:min] and average < range[:max]
        j+=1
      end
      return !match.include?(false)

    end


    def generate_spectrum
      begin
        buffer = RubyAudio::Buffer.float(@config.window_size)
        RubyAudio::Sound.open(@config.file_name) do |snd|
          while snd.read(buffer) != 0
            domain = generate_domain(buffer)
            @spectrum.domains.push(domain)
          end
        end

      rescue => err
        p "error reading audio file: " + err.to_s
        exit
      end
    end

    def sum_domains
      @spectrum.entire_spectrum = Array.new(@spectrum.domains[0].values.length, 0)
      @spectrum.domains.each do |domain|
        @spectrum.entire_spectrum.map!.with_index{ |x,i| x + domain.values[i]}
      end
    end

    def generate_domain(buffer)
      windowed_array = apply_window(buffer.to_a, windows[@config.window_function])
      na = NArray.to_na(windowed_array)
      fft_array = FFTW3.fft(na).to_a[0, @config.window_size/2]
      domain = SpectrumAnalyzer::Domain.new()
      fft_array.each { |x| domain.raw_values.push(x); domain.values.push(x.magnitude)}
      domain
    end

    def analyze_spectrum
      sum_domains
      find_occurrences
    end

    def find_occurrences
      ranges = @config.analysis_ranges
      occurrence_count = 0
      @spectrum.domains.each do |domain|
        ranges.each do |range|
          if find_occurrence(range, domain)
            occurrence_count += 1
            domain.contains_frequency_range = true
          end
        end
      end
      @spectrum.num_occurrences = occurrence_count
    end

    def find_occurrence (range, domain)
      sum_total = 0
      for i in range[:b_index]..range[:t_index]
        sum_total += domain.values[i] if !domain.nil?
      end
      average = sum_total / (range[:t_index] - range[:b_index])
      average > range[:min] and average < range[:max]
    end

    def build_file_info
      file = SpectrumAnalyzer::File.new(@config.file_name)
      file.sample_rate = RubyAudio::Sound.open(file.name).info.samplerate
      file
    end

    def windows
      @window_functions.windows()
    end


    def apply_window(buffer, window_type)
      windowed_array = Array.new()
      i=0
      buffer.each { |x| windowed_array[i] = x * window_type[i]; i+=1}
    end

    def analysis_array
      @config.analysis_array
    end


  end
end


