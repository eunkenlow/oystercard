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

  it "deducts fare from the card" do
    expect{ card.deduct 2.8 }.to change{ card.balance }.by -2.8
  end

  it "is initially not in a journey" do
    expect(card).not_to be_in_journey
  end

  context "when card is topped up" do
    before do
      card.top_up Oystercard::MAXIMUM_LIMIT
    end

    it "touches in oyster card" do
      card.touch_in
      expect(card).to be_in_journey
    end
    it "touches out oyster card" do
      card.touch_in
      card.touch_out
      expect(card).not_to be_in_journey
    end

  end

  it "raises error if insufficient funds" do
    expect{card.touch_in}.to raise_error "You have insufficient funds"
  end

end
