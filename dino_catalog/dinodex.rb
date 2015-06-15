require 'CSV'

class DinoDex
  BIG_SIZE = (4000..Float::INFINITY)
  SMALL_SIZE = (1..4000)
  KEY_MAPPING = {
    name: :genus,
    period: :period,
    carnivore: :carnivore,
    weight_in_lbs: :weight,
    walking: :walking,
    diet: :diet
  }

  def initialize(*files)
    files = ['dinodex.csv', 'african_dinosaur_export.csv'] if files.empty?
    @csvs = []
    files.each do |file|
      @csvs << CSV.read(file, headers: true, header_converters: :symbol,
                              converters: :all)
    end
  end

  def clear
    initialize
    self
  end

  def filter(filter_hash)
    @csvs.each do |csv|
      new_hash = convert_header_keys(csv, filter_hash)
      filter_csv(csv, new_hash)
    end
    self
  end

  def filter_csv(csv, filter_hash)
    csv.delete_if do |row|
      matches = true
      filter_hash.each do |k, v|
        unless row_matches_filter?(row, k, v)
          matches = false
          break
        end
      end
      !matches
    end
  end

  def convert_header_keys(csv, filter_hash)
    lowercase_hash = filter_hash.map { |k, v| Hash[k.downcase, v] }.reduce(:merge)
    if csv.headers.include? :genus
      lowercase_hash.map { |k, v| Hash[KEY_MAPPING[k], v] }.reduce(:merge)
    else
      lowercase_hash
    end
  end

  def row_string_matches?(row, k, v)
    if k == :diet
      return false unless diet_matches?(row, v)
    elsif row.key?(k) && !row[k].include?(v)
      return false
    end
    true
  end

  def row_range_matches?(row, k, v)
    return v.include?(row[k].to_i)
  end

  def row_matches_filter?(row, k, v)
    if v.is_a? String
      return row_string_matches?(row, k, v)
    else
      return row_range_matches?(row, k, v)
    end
    true
  end

  def diet_matches?(row, value)
    if row.key? :diet
      return row[:diet].include? value
    else
      return row[:carnivore] == 'Yes' if value == 'Carnivore'
      return row[:carnivore] == 'No' if value != 'Carnivore'
    end
    false
  end

  def dino_fact(dino)
    line = ["#{dino.headers[0].capitalize}: #{dino[dino.headers[0]]}"]
    dino.each do |k, v|
      line << " - #{k}: #{v}" unless v.nil? || k == dino.headers[0]
    end
    line
  end

  def facts
    fact_list = []
    @csvs.each do |csv|
      csv.each do |dino|
        fact_list << dino_fact(dino).join("\n")
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
    @csvs
      .map { |csv| csv.map(&:to_hash) }
      .flatten
      .map { |h| h.map { |k, v| Hash[k.to_s.capitalize, v] }.reduce(:merge) }
      .to_s.gsub('=>', ': ').gsub('nil', '"NULL"')
  end
end
