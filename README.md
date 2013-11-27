[![Code Climate](https://codeclimate.com/github/jusroberts/spectrum-analyzer.png)](https://codeclimate.com/github/jusroberts/spectrum-analyzer) [![Gem Version](https://badge.fury.io/rb/spectrum-analyzer.png)](http://badge.fury.io/rb/spectrum-analyzer)
# Ruby Sound Spectrum Analyzer

Have you ever wanted to break apart a sound file and see what frequencies make it up? Well, you're in luck! This program does JUST THAT!!!!

##How do I do?

Right now, it's very basic. You need to initiate all the processes by yourself.
```ruby
require 'spectrum-analyzer'
```
configure your stuff
```ruby
c = SpectrumAnalyzer.configuration
c.file_name = "whatever"
c.window_function = :hanning #or :rectangular. Those are the only two implemented currently
c.window_size = 512 #MUST BE A POWER OF 2!!!! 128, 256, 512, 1024, etc. If not, I cannot guarantee your results. In fact, you'll probably break FFTW3. Sorry.
c.analysis_ranges = [] #This does things! Put an array with values you want to define your analysis range.
```

generate a spectrum
```ruby
g = SpectrumAnalyzer.generate
g.build_spectrum
```
You now have a bunch of "domains" held in the spectrum (SpectrumAnalyzer.spectrum).
```ruby
s = SpectrumAnalyzer.spectrum
s.domains
```
These domains are an array of frequencies that occur over the time slice defined by the window_size. The values are currently magnitudes of the complex numbers, and the complex numbers themselves. They represent the amplitude of the frequency ranges. The spectrum super class will contain the number of occurrences that match your analysis_ranges, and each domain will know if is an occurrence or not.

The last feature before this is released as 0.2.0 will be quick_analyze. This will return true on the first occurrence of the analysis_ranges. This is useful if you are just trying to see if a wav file contains your ranges or not.

##Contributing to spectrum-analyzer
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

##Copyright

Copyright (c) 2013 Justin Roberts. See LICENSE.txt for
further details.

