require_relative '../data_science'

MOCK_DATA = {
  A: { pos: 12, neg: 3 }, 
  B: { pos: 9, neg: 12 }
}

BAD_MOCK_DATA = {
  A: { pos: -5, neg: 32 }, 
  B: { pos: 21, neg: 22 }
}

describe Analyzer do
  it 'should not throw an error on analyzing' do
    expect { ds = Analyzer.new(MOCK_DATA) }.not_to raise_error
  end

  it 'should return the total sample size for each cohort' do
    ds = Analyzer.new(MOCK_DATA)
    expect(ds.sample_size(:A)).to eq(15)
    expect(ds.sample_size(:B)).to eq(21)
  end

  it 'should return the number of conversions for each cohort' do
    ds = Analyzer.new(MOCK_DATA)
    expect(ds.num_conversions(:A)).to eq(12)
    expect(ds.num_conversions(:B)).to eq(9)
  end

  it 'should return the correct chi-test p-value' do
    ds = Analyzer.new(MOCK_DATA)
    expect(ds.p_value_test).to be_within(0.0001).of(0.0258979)
  end
  
  it 'should return the conversion rate percents' do
    ds = Analyzer.new(MOCK_DATA)
    expect(ds.conversion_rate(:A)).to be_within(0.01).of(0.80)
    expect(ds.conversion_rate(:B)).to be_within(0.01).of(0.4286)
  end

  it 'should get the 95% confidence interval correctly' do
    ds = Analyzer.new(MOCK_DATA)
    ci = ds.confidence_interval(:A, 0.95)
    expect(ci[0]).to be_within(0.0005).of(0.59757579)
    expect(ci[1]).to be_within(0.0005).of(1.00242420)
  end

  it "should give a confidence that the current leader is better than random" do
    ds = Analyzer.new(MOCK_DATA)
    expect(ds.independence_test).to be_within(0.001).of(0.974157566)
  end


  it 'should fail on bad data' do
    expect { ds = Analyzer.new(BAD_MOCK_DATA) }.to raise_error
  end
end
