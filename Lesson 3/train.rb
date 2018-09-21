class Train
  attr_reader :number, :type, :speed, :wagons
  
  def initialize(number, type)
    @number       = number
    @type         = type
    @wagons = []
    @speed        = 0
  end
  
  def increase_speed(speed)
    @speed += speed
  end
  
  def decrease_speed(speed)
    @speed -= speed if @speed >= speed
  end
  
  def set_route(route)
    @route           = route
    @current_station = 0
    route.stations.first.add_train(self)
  end
  
  def current_station
    @route.stations[@current_station]
  end
  
  def next_station
    @route.stations[@current_station + 1]
  end
  
  def previous_station
    if @current_station > 0
      @route.stations[@current_station - 1]
    end
  end
  
  def go_to_next_station
    if next_station
      current_station.train_departure(self)
      @current_station += 1
      current_station.add_train(self)
    end
  end
  
  def go_to_previous_station
    if @current_station > 0
      current_station.train_departure(self)
      @current_station -= 1
      current_station.add_train(self)
    end
  end
end
