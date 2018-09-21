require_relative('station')
require_relative('route')
require_relative('train')
require_relative('cargo_wagon')
require_relative('passenger_wagon')
require_relative('passenger_train')
require_relative('cargo_train')

class Railway

end

station_moscow = Station.new("Москва")
station_spb = Station.new("Санкт-Петербург")
station_tver = Station.new("Тверь")
station_okul = Station.new("Окуловка")
route_to_spb = Route.new(station_moscow, station_spb)
route_to_spb.add_station(station_tver)
route_to_spb.add_station(station_okul)
train_pass = PassengerTrain.new(777, 'passenger')
train_cargo = CargoTrain.new(888, 'cargo_train')
train_pass.set_route(route_to_spb)
train_cargo.set_route(route_to_spb)

pass_wagon = PassengerWagon.new
puts train_pass.wagons



