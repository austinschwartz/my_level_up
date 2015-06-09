require 'CSV'

class DinoDex
  BIG_SIZE = (4000..Float::INFINITY)
  SMALL_SIZE = (1..4000)

  def initialize(*csv_files)
    csv_files = ['dinodex.csv', 'african_dinosaur_export.csv'] if csv_files.empty?
    @csvs = []
    csv_files.each do |file|
      @csvs << CSV.read(file, headers: true, header_converters: :symbol, converters: :all)
    end
  end

  def query(query_hash)
    lowercase_hash = query_hash.map { |k, v| { k.downcase => v } }.reduce(:merge)
    @csvs.each do |csv|
      if csv.headers[0] == :name
        query_master_csv(csv, lowercase_hash)
      else
        query_african_csv(csv, lowercase_hash)
      end
    end
    self
  end

  def diet_matches(row, value)
    if row.key? :diet
      return row[:diet].include? value
    else
      return row[:carnivore] == 'Yes' if value == 'Carnivore'
      return row[:carnivore] == 'No' if value != 'Carnivore'
    end
    false
  end

  def query_master_csv(csv, query_hash)
    csv.delete_if do |row|
      matches = true
      query_hash.each do |k, v|
        if v.is_a? String
          if k == :diet && !diet_matches(row, v)
            matches = false
            break
          elsif row.key?(k) && !row[k].include?(v)
            matches = false
            break
          end
        elsif v.is_a? Range
          matches = false unless v.include?(row[k].to_i)
          break
        end
      end
      !matches
    end
  end

  def query_african_csv(csv, query_hash)
    mapping = {
      name: :genus,
      period: :period,
      carnivore: :carnivore,
      weight_in_lbs: :weight,
      walking: :walking,
      diet: :diet,
    }
    new_hash = query_hash.map { |k, v| { mapping[k] => v } }.reduce(:merge)
    query_master_csv(csv, new_hash)
  end

  def clear
    initialize
    self
  end

  def facts
    fact_list = []
    @csvs.each do |csv|
      csv.each do |row|
        str = ["#{row.headers[0].capitalize}: #{row[row.headers[0]]}"]
        row.each do |k, v|
          str << " - #{k}: #{v}" unless v.nil? || k == row.headers[0]
        end
        fact_list << str.join("\n")
      end
    end
    fact_list.join("\n\n")
  end

  def to_names
    res = []
    @csvs.each do |csv|
      csv.each do |row|
        res << row[row.headers[0]]
      end
    end
    res.sort
  end

  def to_json
=begin
    @csvs
      .map { |csv| csv.map(&:to_hash) }
      .flatten
      .map { |hash| hash.map { |k, v|  Hash[k.to_s.capitalize, v] }.reduce(:merge) }
      .to_s.gsub('=>', ': ').gsub('nil', '"NULL"')
=end
    @csvs.map do |csv|
      csv.map(&:to_hash)
    end.flatten.map do |hash|
      hash.map do |k, v| 
        Hash[k.to_s.capitalize, v]
      end.reduce(:merge)
    end.to_s.gsub('=>', ': ').gsub('nil', '"NULL"')
  end

  def to_s
    to_names.to_s
  end
end
