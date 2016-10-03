class Oystercard

  attr_reader :balance
  attr_accessor :in_use
  MAXIMUM_LIMIT = 90
  MINIMUM_AMOUNT = 1

  def initialize
    @balance = 0
    @in_use = false
  end

  def top_up(money)
    raise ("Balance exceeded maximum limit of #{MAXIMUM_LIMIT}") if @balance + money > MAXIMUM_LIMIT
    @balance += money
  end

  def in_journey?
    @in_use
  end

  def touch_in
    raise ("You have insufficient funds") if @balance < MINIMUM_AMOUNT
    @in_use = true
  end

  def touch_out
    deduct(MINIMUM_AMOUNT)
    @in_use = false
  end

private

  def deduct(fare)
    @balance -= fare
  end

end
