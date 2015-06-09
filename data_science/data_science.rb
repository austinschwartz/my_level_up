require_relative 'data_parser'
require 'abanalyzer'

class Analyzer
  def initialize(data)
    @data = data
    @tester = ABAnalyzer::ABTest.new data
    throw RuntimeException if data.values.any?{ |h| h.values.any?{ |v| v < 0 } }
  end

  def p_value_test
    @tester.chisquare_p
  end

  def independence_test
    1 - @tester.chisquare_p
  end

  def sample_size(sym)
    @data[sym].values.reduce(:+)
  end

  def num_conversions(sym)
    @data[sym][:pos]
  end
  
  def conversion_rate(sym)
    total = @data[sym][:pos] + @data[sym][:neg] + 0.0
    @data[sym][:pos] / total
  end

  def confidence_interval(sym, percent)
    total = @data[sym][:pos] + @data[sym][:neg]
    ABAnalyzer::confidence_interval(@data[sym][:pos], total, percent)
  end

end
