require_relative 'journey_log'

class Oystercard

  attr_reader :balance
  attr_reader :journeys

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  def initialize
    @balance = 0
    @journeys = JourneyLog.build
  end

  def top_up(amount)
    raise "Balance can't exceed 90" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station_object)
    raise "Not enough funds" if balance < MINIMUM_BALANCE
    deduct(journeys.journeys.last.fare) if journeys.in_journey?
    journeys.begin(station_object)
  end

  def touch_out(station_object)
    journeys.finish(station_object)
    deduct(journeys.journeys.last.fare)
  end

private

  def deduct(amount)
    @balance -= amount
  end

end
