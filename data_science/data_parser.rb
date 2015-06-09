require 'json'

class DSParser
  attr_accessor :data
  def initialize(path)
    @file_text = File.read(path)
    @json = JSON.parse(@file_text)
    @data = {}
    parse_json
  end

  def parse_json
    @json.each do |line|
      group = %Q{#{line['cohort']}}.to_sym
      @data[group] ||= {pos: 0, total: 0, neg: 0}
      @data[group][:pos] += line['result']
      @data[group][:total] ||= 0
      @data[group][:total] += 1
    end
    @data.each { |k, v| @data[k][:neg] = @data[k][:total] - @data[k][:pos] }
    @data.each { |k, v| @data[k].delete(:total) }
  end
end
