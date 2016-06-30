class JourneyLog

  def initialize(log_type)
    @log = []
    @log_type = log_type
  end

  def self.build
    new(Journey)
  end
  
  def begin(station_object)
    new_log(station_object)
  end

  def finish(station_object)
    current_journey.set_exit(station_object)
  end

  def in_journey?
    log.empty? ? false : !log.last.complete?
  end

  def journeys
    log
  end

  private

  attr_reader :log

  def new_log(station_object=nil)
    new = @log_type.new(station_object)
    log << new
    new
  end

  def current_journey
    in_journey? ? log.last : new_log
  end
end
