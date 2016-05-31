require_relative 'station'

class Oystercard

  attr_reader :balance, :journey_log

  MAX_LIMIT = 90
  MIN_BALANCE = 1
  MIN_FARE = 1

  def initialize
    @balance = 0
    @journey_log = []
    @current_journey = {}
  end

  def top_up(amount)
    fail "Balance can not exceed £#{MAX_LIMIT}" if @balance + amount > MAX_LIMIT
  	@balance += amount
  end

  def touch_in(station)
    fail "Insufficient balance." if balance < MIN_BALANCE
    @current_journey[:entry_station] = station
  end

  def in_journey?
    !@current_journey.empty?
  end

  def touch_out(station)
    deduct
    @current_journey[:exit_station] = station
    @journey_log << @current_journey
    @current_journey = {}
  end

private

 def deduct
    @balance -= MIN_FARE
  end

end
