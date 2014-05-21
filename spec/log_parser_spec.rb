require './lib/log_parser'

describe LogParser do

  data = <<-DATA
W, [2014-05-10T13:49:19.049260 #83516]  WARN -- : deliver B2C systems
W, [2014-05-10T13:49:19.049408 #83516]  WARN -- : transition sticky bandwidth
  DATA

  it 'can parse a log and return the dates the log covers' do
    log_parser = LogParser.new(data)
    expect(log_parser.log_dates).to eq [
                                     '2014-05-10T13:49:19.049260',
                                     '2014-05-10T13:49:19.049408'
                                   ]
  end

  it 'can parse a log and return the number of logs on a given date' do
    log_parser = LogParser.new(data)
    expect(log_parser.count_log_by_date('2014-05-10T13:49:19.049408')).to eq 2
  end

  it 'should return the number of logs of a given type' do
    log_parser = LogParser.new(data)
    expect(log_parser.count_log_types).to eq [
                                     {
                                       "WARN" => 2
                                     }
                                   ]
  end

end