module SpectrumAnalyzer
  module Objects
    class Spectrum
      attr_accessor :domains, :entire_spectrum, :num_occurrences

      def initialize(spectrum = [])
        @config = SpectrumAnalyzer.configuration
        @domains = spectrum
      end

      def sum_domains
        @entire_spectrum = Array.new(@domains[0].values.length, 0)
        @domains.each do |domain|
          @entire_spectrum.map!.with_index{ |x,i| x + domain.values[i]}
        end
      end

      def add_domain(buffer)
        domain = SpectrumAnalyzer::Objects::Domain.new(buffer)
        @domains.push(domain)
      end

      def sum_occurrences
        ranges = @config.analysis_ranges
        occurrence_count = 0
        @domains.each do |domain|
          ranges.each do |range|
            if find_occurrence(range, domain)
              occurrence_count += 1
              domain.contains_frequency_range = true
            end
          end
          end
        @num_occurrences = occurrence_count
      end

      def find_occurrence (range, domain)
        sum_total = 0
        for i in range[:b_index]..range[:t_index]
          sum_total += domain.values[i] if !domain.nil?
        end
        average = sum_total / (range[:t_index] - range[:b_index])
        average > range[:min] and average < range[:max]
      end
    end
  end
end
