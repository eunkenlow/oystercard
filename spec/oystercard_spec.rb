require 'oystercard'
describe Oystercard do

  subject(:card) {described_class.new}

  it "has a balance" do
    expect(card.balance).to eq 0
  end

  it {is_expected.to respond_to(:top_up).with(1).argument}
  it "tops up the oyster card" do
    card.top_up(20)
    expect(card.balance).to eq 20
  end

end
