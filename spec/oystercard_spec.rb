require 'oystercard'
describe Oystercard do

  subject(:card) {described_class.new}

  it "has a balance" do
    expect(card.balance).to eq 0
  end

  it "tops up the oyster card" do
    expect{ card.top_up 20 }.to change{ card.balance }.by 20
  end

  it "raises error if limit is exceeded" do
    maximum = Oystercard::MAXIMUM_LIMIT
    card.top_up maximum
    expect{card.top_up(1)}.to raise_error "Balance exceeded maximum limit of #{Oystercard::MAXIMUM_LIMIT}"
  end

  it {is_expected.to respond_to(:deduct).with(1).argument}
end
