class Station
  attr_reader :name
  
  def initialize(name)
    @name = name
    @trains = []
  end
  
  def add_train(train)
    @trains << train
  end
  
  def show_trains_in_station
    @trains.each {|train| puts train.number}
  end
  
  def show_trains_in_station_by_type
    passanger_train = 0
    freight_train = 0
    @trains.each do |train|
      if train.type == 'passenger'
        passanger_train += 1
      else
        freight_train += 1
      end
    end
    puts "Количество пассажирских поездов на станции: #{passanger_train}. Количество товарных: #{freight_train}"
  end
  
  def train_departure(train)
    @trains.delete(train) if train.current_station == self
  end

end

class Route
  attr_reader :route
  
  def initialize(start_station, end_station)
    @route = [start_station, end_station]
  end
  
  def show_stations
    @route.each {|station| puts station.name}
  end
  
  def add_station(station)
    @route.insert(-2, station)
  end
  
  def delete_station(station)
    @route.delete(station)
  end
end

class Train
  attr_accessor :speed, :car_number
  attr_reader :current_station, :number, :type
  
  def initialize(number, type, car_number)
    @number = number
    @type = type
    @car_number = car_number
    @speed = 0
  end
  
  def speed_up(speed)
    self.speed = speed
  end
  
  def stop
    self.speed = 0
  end
  
  def add_car
    self.car_number +=1 if @speed == 0
  end
  
  def remove_car
    self.car_number -=1 if @speed == 0
  end
  
  def set_route(route)
    @train_route = route
    @current_station = route.route.first
  end
  
  def show_next_station
    @train_route.route.each_with_index do |station, index|
      puts @train_route.route[index+1].name if station.name == @current_station.name
    end
  end
  
  def show_previous_station
    @train_route.route.each_with_index do |station, index|
      puts @train_route.route[index-1].name if station.name == @current_station.name && index != 0
    end
  end
  
  def go_to_next_station
    @current_station = @train_route.route[@train_route.route.index(@current_station) + 1]
  end
  
  def go_to_previous_station
    @current_station = @train_route.route[@train_route.route.index(@current_station) - 1]
  end


end

station1 = Station.new("StartStationName")
station2 = Station.new("EndStationName")
station3 = Station.new("MiddleStationName")
route = Route.new(station1, station2)
route.add_station(station3)
route.show_stations
train = Train.new(777, 'passenger', 3)
train2 = Train.new(888, 'freight_train', 3)
train.set_route(route)
puts "Speed: #{train.speed}"
train.add_car
puts "Car number: #{train.car_number}"
train.speed_up(50)
puts train.current_station.name
train.go_to_next_station
puts train.current_station.name
train.go_to_previous_station
train2.set_route(route)
station1.add_train(train)
station1.add_train(train2)
station1.show_trains_in_station_by_type
station1.train_departure(train)
station1.show_trains_in_station_by_type
