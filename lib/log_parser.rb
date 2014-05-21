class LogParser

  def initialize(data)
    @data_lines = data.split("\n")
  end

  def log_dates
    @data_lines.map do |line|
      date(line)
    end
  end

  def count_log_by_date(date)
    formatted_date = format_date(date)
    log = 0
    dates_array = log_dates
    dates_array.each do |date_to_match|
      if format_date(date_to_match) == formatted_date
        log += 1
      end
    end
    log
  end

  def count_log_types
    types_hash = {}
    log_types = @data_lines.map do |line|
      type = log_type(line)
      if types_hash.has_key?(type)
        types_hash[type] += 1
      elsif types_hash[type] == nil
        types_hash[type] = 1
      end
      types_hash
    end
    log_types.uniq
  end

  private

  def format_date(date)
    parse_date(date).strftime("%d-%m-%y")
  end

  def parse_date(date)
    Time.parse(date)
  end

  def date(line)
    date = line.scan /\[(\d.+)#/
    date.flatten!
    characters = date[0].chars
    characters.delete_at(-1)
    characters.join
  end

  def log_type(line)
    type = line.scan /( [A-Z]+ )/
    "#{type.flatten[0].strip}"
  end

end