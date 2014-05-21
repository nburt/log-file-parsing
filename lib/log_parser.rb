class LogParser

  def initialize(data)
    @data_lines = data.split("\n")
  end

  def dates
    dates_array = []
    @data_lines.each do |line|
      date = line.scan /\[(\d.+)#/
      date.flatten!
      characters = date[0].chars
      characters.delete_at(-1)
      date = characters.join
      dates_array << date
    end
    dates_array
  end

  def count_log_by_date(date)
    new_date = Time.parse(date)
    formatted_date = new_date.strftime("%d-%m-%y")
    log = 0
    dates_array = dates
    dates_array.each do |date_to_match|
      if Time.parse(date_to_match).strftime("%d-%m-%y") == formatted_date
        log += 1
      end
    end
    log
  end

  def count_log_types
    types_array = []
    types_hash = {}
    @data_lines.each do |line|
      type = line.scan /( [A-Z]+ )/
      if types_hash.has_key?(type.flatten[0].strip)
        types_hash["#{type.flatten[0].strip}"] += 1
      elsif types_hash["#{type.flatten[0].strip}"] == nil
        types_hash["#{type.flatten[0].strip}"] = 1
      end
      types_array << types_hash
    end
    types_array.uniq
  end

end