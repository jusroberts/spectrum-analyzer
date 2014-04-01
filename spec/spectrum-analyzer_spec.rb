require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "SpectrumAnalyzer" do

  before :each do
    @window_size = 512
    @file_name = 'spec/analyze.wav'
    SpectrumAnalyzer.configuration(
      {
          :window_size     => 512,
          :window_function => :hanning,
          :analysis_ranges => [
              { :b_index => 27, :t_index => 47,   :min => 1,    :max => 2},     #Low area
              { :b_index => 58, :t_index => 64,   :min => 2.5,  :max => 6.5},   #High peak
              { :b_index => 70, :t_index => 74,   :min => 2.0,  :max => 4.2 },  #Mid peak
              { :b_index => 82, :t_index => 109,  :min => 0.8,  :max => 2}      #Low area
          ],
          :file_name        => "spec/analyze.wav"
      }
  )

  end
  it 'returns true if matches are found in the analysis' do
    SpectrumAnalyzer.quick_analyze.should == true
  end

  it 'returns true if matches are found in the analysis' do
    SpectrumAnalyzer.contains_frequency_range?.should == true
  end

  it 'creates an analysis object with information about the analysis performed' do
    analysis = SpectrumAnalyzer.analyze

    analysis.spectrum.should be_a SpectrumAnalyzer::Objects::Spectrum
    analysis.file.should be_a SpectrumAnalyzer::Objects::File

    analysis.spectrum.num_occurrences.should == 22

    analysis.spectrum.domains[0].should be_a SpectrumAnalyzer::Objects::Domain

    analysis.spectrum.domains[0].values.length.should == @window_size / 2
    analysis.spectrum.domains[0].raw_values.length.should == @window_size / 2
    analysis.spectrum.domains[0].values[0].class.should be Float
    analysis.spectrum.domains[0].raw_values[0].class.should be Complex

    analysis.file.name.should == @file_name
    analysis.file.sample_rate.should == 8000

  end

  it 'bombs out without a file :(' do
    SpectrumAnalyzer.configuration.file_name = ""

    expect{SpectrumAnalyzer.analyze}.to raise_error(StandardError)
  end
  #
  #it 'bombs out without a window :( - Analyze' do
  #  SpectrumAnalyzer.configuration.window_function = []
  #  SpectrumAnalyzer.configuration.file_name = @file_name
  #
  #  expect(SpectrumAnalyzer.analyze).to raise_error
  #
  #end
  #
  #it 'bombs out without a window :( - Quick Analyze' do
  #  SpectrumAnalyzer.configuration.window_function = []
  #  SpectrumAnalyzer.configuration.file_name = @file_name
  #
  #  expect(SpectrumAnalyzer.quick_analyze).to raise_error
  #
  #end
end
