require './lib/oystercard'
card = Oystercard.new
card.top_up(10)
card.touch_in("Bank")
p card.journeys
card.touch_out("Southwark")
card.touch_in("Aldgate")
card.touch_out("Tower Hill")
p card.journeys
