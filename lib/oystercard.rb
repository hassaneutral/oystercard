require 'station'

class Oystercard

  attr_reader :balance, :entry_station

  MAX_LIMIT = 90
  MIN_BALANCE = 1
  MIN_FARE = 1

  def initialize
    @balance = 0
    @entry_station = nil
  end

  def top_up(amount)
    fail "Balance can not exceed £#{MAX_LIMIT}" if @balance + amount > MAX_LIMIT
  	@balance += amount
  end

  def touch_in(station)
    fail "Insufficient balance." if balance < MIN_BALANCE
    @entry_station = station
  end

  def in_journey?
     @entry_station ? true : false
  end

  def touch_out
    deduct
    @entry_station = nil
  end

private

 def deduct
    @balance -= MIN_FARE
  end

end
