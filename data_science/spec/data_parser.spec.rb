require_relative '../data_parser'

describe DSParser do
  it 'should throw an error on invalid json' do
    expect { DSParser.new('data/bad_json.json') }
    .to raise_error
  end

  it 'should return correctly formatted data' do
    expect { DSParser.new('data/data_mock.json').data }
    .not_to raise_error
  end
end
