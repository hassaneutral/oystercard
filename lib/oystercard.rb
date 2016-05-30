class Oystercard

  attr_reader :balance

  MAX_LIMIT = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "Balance can not exceed £#{MAX_LIMIT}" if @balance + amount > MAX_LIMIT
  	@balance += amount
  end

  def deduct(amount)
  	@balance -= amount
  end

  def touch_in
    @in_journey = true
  end

  def in_journey?
    @in_journey ? true : false
  end

  def touch_out
    @in_journey = false
  end

end