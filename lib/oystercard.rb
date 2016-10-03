class Oystercard

  attr_reader :balance
  MAXIMUM_LIMIT = 90

  def initialize
    @balance = 0
  end

  def top_up(money)
    raise ("Balance exceeded maximum limit of #{MAXIMUM_LIMIT}") if @balance + money > MAXIMUM_LIMIT
    @balance += money
  end

end
