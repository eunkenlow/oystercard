require 'oystercard'
describe Oystercard do

  subject(:card) {described_class.new}
  let(:station1) {double :entry_station}

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

  it "is initially not in a journey" do
    expect(card).not_to be_in_journey
  end

  context "when card is topped up" do
    before do
      card.top_up Oystercard::MAXIMUM_LIMIT
    end

    it "touches in oyster card" do
      card.touch_in(station1)
      expect(card).to be_in_journey
    end
    it "touches out oyster card" do
      card.touch_in(station1)
      card.touch_out
      expect(card).not_to be_in_journey
    end

  end

  it "raises error if insufficient funds" do
    expect{card.touch_in(station1)}.to raise_error "You have insufficient funds"
  end

  it "deducts card balance on touch out" do
    expect{card.touch_out}.to change{card.balance}.by(-Oystercard::MINIMUM_AMOUNT)
  end

  it "remembers the entry station after touch in" do
    card.top_up Oystercard::MAXIMUM_LIMIT
    card.touch_in(station1)
    expect(card.entry_station).to eq station1
  end

  it "returns nil after touch out" do
    card.top_up Oystercard::MAXIMUM_LIMIT
    card.touch_in(station1)
    card.touch_out
    expect(card.entry_station).to eq nil
  end

end
