class Oystercard

  attr_reader :balance, :entry_station
  MAXIMUM_LIMIT = 90
  MINIMUM_AMOUNT = 1

  def initialize
    @balance = 0
  end

  def top_up(money)
    raise ("Balance exceeded maximum limit of #{MAXIMUM_LIMIT}") if @balance + money > MAXIMUM_LIMIT
    @balance += money
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(station)
    raise ("You have insufficient funds") if @balance < MINIMUM_AMOUNT
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_AMOUNT)
    @entry_station = nil
  end

private

  def deduct(fare)
    @balance -= fare
  end

end
