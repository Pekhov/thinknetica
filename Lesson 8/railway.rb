require_relative('station')
require_relative('route')
require_relative('train')
require_relative('wagon')
require_relative('cargo_wagon')
require_relative('passenger_wagon')
require_relative('passenger_train')
require_relative('cargo_train')

class Railway
  attr_accessor :stations, :trains, :routes, :wagons
  
  def initialize
    @stations = []
    @trains = []
    @routes = []
    @wagons = []
  end
  
  MAIN_MENU = <<-MENU
  
  Введите 1, для управления станциями
  Введите 2, для управления маршрутами
  Введите 3, для управления поездами и вагонами
  Введите 0, для выхода
  MENU
  
  TRAIN_MENU = <<-MENU
  Введите 1, если хотите создать поезд
  Введите 2, если хотите назначить поезду маршрут
  Введите 3, если хотите управлять вагонами
  Введите 4, если хотите переместить поезд на следующую станцию
  Введите 5, если хотите переместить поезд на предыдущую станцию
  Введите 0, для возврата в главное меню
  MENU
  
  ROUTE_MENU = <<-MENU
  Введите 1, если хотите создать маршрут
  Введите 2, если хотите добавить станцию в маршрут
  Введите 3, если хотите удалить станцию
  Введите 4, если хотите просмотреть станции в маршруте
  Введите 0, для возврата в главное меню
  MENU
  
  CREATE_TRAIN_MENU = <<-MENU
  Введите 1, если хотите создать пассажирский поезд
  Введите 2, если хотите создать грузовой поезд
  MENU
  
  WAGON_MANAGER = <<-MENU
  Введите 1, что бы прицепить вагон
  Введите 2, что бы отцепить вагон
  Введите 3, что бы занять место в вагоне
  Введите 4, что бы просмотреть вагоны у поезда
  MENU
  
  def menu
    loop do
      print MAIN_MENU
      case gets.chomp.to_i
      when 1 then station_manager
      when 2 then route_manager
      when 3 then train_manager
      when 0 then break
      end
    end
  end
  
  def show_stations_and_train
    @stations.each do |station|
      puts "Станция #{station.name}"
      if station.trains.any?
        station.train_to_block do |train|
          puts "Поезд №#{train.number}, Тип:#{train.type}, Кол-во вагонов: #{train.wagons.count}"
          show_train_wagons(train)
        end
      else
        puts "На станции нет поездов"
      end
    end
  end
  
  private # Эти методы не будут вызываться из "вне" и не будут использоваться напрямую пользователем
  
  # Методы станций
  
  def station_manager
    print <<-EOF
\nВведите 1, для создания станции
Введите 2, для просмотра всех станций
Введите 3, для просмотра поездов на станции
Введите 0, для возврата в главное меню
    EOF
    case gets.chomp.to_i
    when 1 then create_station
    when 2 then show_all_stations
    when 3 then show_train_on_station
    when 0 then menu
    end
  end
  
  def create_station
    print "Введите название станции "
    @stations << Station.new(gets.chomp)
    puts "Создали станцию: #{@stations.last.name}"
  end
  
  def show_all_stations
    @stations.each.with_index(1) do |station, index|
      puts "#{index} - #{station.name}"
    end
  end
  
  def show_train_on_station
    #select_station.trains.each {|train| puts "Поезд №#{train.number} - #{train.type}" }
    station = select_station
    if station.trains.any?
      station.train_to_block do |train|
        puts "Поезд №#{train.number}, Тип:#{train.type}, Кол-во вагонов: #{train.wagons.count}"
      end
    else
      puts "На станции нет поездов"
    end
  end
  
  
  # Методы поездов
  
  def train_manager
    print TRAIN_MENU
    case gets.chomp.to_i
    when 1 then create_train
    when 2 then assign_route_to_train
    when 3 then wagon_manager
    when 4 then move_to_next_station
    when 5 then move_to_previous_station
    when 0 then menu
    end
  end
  
  def create_train
    print CREATE_TRAIN_MENU
    train_type = gets.chomp.to_i
    print "Введите номер поезда "
    number = gets.chomp
    if train_type == 1
      @trains << PassengerTrain.new(number)
      puts "Создали пассажирский поезд с номером: #{@trains.last.number}"
    elsif train_type == 2
      @trains << CargoTrain.new(number)
      puts "Создали грузовой поезд с номером: #{@trains.last.number}"
    end
  rescue StandardError => msg
    puts "Ошибка! #{msg}"
    retry
  end
  
  def assign_route_to_train
    if @trains.any? and @routes.any?
      select_train.set_route(select_route)
      puts "Назначили поезду маршрут"
    else
      puts "Сначала нужно создать поезда и маршруты"
    end
  end
  
  def move_to_next_station
    train = select_train
    if train.route
      train.go_to_next_station
      puts "Переместили поезд"
    else
      puts "Поезду не назначен маршрут"
    end
  end
  
  def move_to_previous_station
    train = select_train
    if train.route
      train.go_to_previous_station
      puts "Переместили поезд"
    else
      puts "Поезду не назначен маршрут"
    end
  end
  
  def wagon_manager
    print WAGON_MANAGER
    case gets.chomp.to_i
    when 1 then add_wagon_to_train
    when 2 then remove_wagon_from_train
    when 3 then take_place
    when 4 then show_train_wagons
    when 0 then menu
    end
  end
  
  def add_wagon_to_train
    train = select_train
    if train.type == 'passenger'
      print "Укажите количество мест в вагоне "
      sitting_place = gets.chomp.to_i
      wagon = PassengerWagon.new(sitting_place)
      train.add_wagon(wagon)
    else
      print "Укажите общий объем вагона "
      volume = gets.chomp.to_i
      wagon = CargoWagon.new(volume)
      train.add_wagon(wagon)
    end
    puts "Прицепили вагон"
    @wagons << wagon
  end
  
  def remove_wagon_from_train
    train = select_train
    if train.wagons.any?
      train.remove_wagon(train.wagons.last)
      puts "Отцепили вагон"
    else
      puts "У поезда нет вагонов"
    end
  end
  
  def select_wagon(train)
    print "Выберите вагон"
    if train.type == 'passenger'
      train.wagons.each.with_index(1) do |wagon, index|
        if wagon.type == 'passenger'
          puts "#{index} - Вагон пассажирский №#{index} - свободных мест: #{wagon.get_free_place}"
        else
        
        end
      end
    else
      train.wagons.each.with_index(1) do |wagon, index|
        if wagon.type == 'cargo'
          puts "#{index} - Вагон грузовой №#{index} - свободный объем: #{wagon.get_free_volume}"
        end
      end
    end
    train.wagons[gets.chomp.to_i - 1]
  end
  
  def take_place
    train = select_train
    wagon = select_wagon(train)
    if wagon.type == 'passenger'
      puts wagon.take_sitting_place ? "Заняли место" : "Невозможно занять место"
    else
      print "Введите требуемый объем грузового вагона. Доступно: #{wagon.get_free_volume} "
      volume = gets.chomp.to_i
      puts wagon.take_volume(volume) ? "Заняли место" : "Невозможно занять место"
    end
  end
  
  def show_train_wagons(train = select_train)
    wagon_number = 1
    train.wagons_to_block do |wagon|
      puts "Вагон №#{wagon_number}, Тип: #{wagon.type}"
      if wagon.type == 'passenger'
        puts "Количество свободных мест: #{wagon.get_free_place}"
        puts "Количество занятых мест: #{wagon.get_busy_place}"
      else
        puts "Количество свободного объема: #{wagon.get_free_volume}"
        puts "Количество занятого объема: #{wagon.get_busy_volume}"
      end
      wagon_number += 1
    end
  end
  
  # Методы маршрутов
  
  def route_manager
    print ROUTE_MENU
    case gets.chomp.to_i
    when 1 then create_route
    when 2 then add_station_to_route
    when 3 then delete_station_from_route
    when 4 then show_station_in_route
    when 0 then menu
    end
  end
  
  def create_route
    if @stations.count > 1
      puts "Введите начальную станцию маршрута"
      start_station = select_station
      puts "Введите конечную станцию маршрута"
      end_station = select_station
      @routes << Route.new(start_station, end_station)
      puts "Создали маршрут"
    else
      puts "Недостаточно станций для создания маршрута"
      menu
    end
  end
  
  def add_station_to_route
    if @stations.any? and @routes.any?
      select_route.add_station(select_station)
      puts "Добавили станцию к маршруту"
    else
      puts "Сначала заведите новые станции и маршруты"
      menu
    end
  end
  
  def delete_station_from_route
    if @stations.any? and @routes.any?
      route = select_route
      if route.delete_station(select_route_station(route))
        puts "Удалили станцию из маршрута"
      else
        puts "Невозможно удалить станцию"
      end
    else
      puts "Сначала заведите новые станции и маршруты"
      menu
    end
  end
  
  def show_station_in_route
    select_route.show_stations
  end
  
  # Общие методы
  
  def select_route_station(route)
    print "Введите порядковый номер станции:"
    route.show_stations
    route.stations[gets.chomp.to_i - 1]
  end
  
  def select_station
    print "Введите порядковый номер станции:"
    @stations.each.with_index(1) do |station, index|
      puts "#{index} - #{station.name}"
    end
    @stations[gets.chomp.to_i - 1]
  end
  
  def select_route
    @routes.each.with_index(1) do |route, index|
      print "Введите порядковый номер маршрута:"
      puts "#{index} - Маршрут #{route.stations.first.name} - #{route.stations.last.name}"
    end
    @routes[gets.chomp.to_i - 1]
  end
  
  def select_train
    print "Введите порядковый номер поезда:"
    @trains.each.with_index(1) do |train, index|
      puts "#{index} - Поезд №#{train.number} - #{train.type}"
    end
    @trains[gets.chomp.to_i - 1]
  end

end

def seed
  rr = Railway.new
  moscow_station = Station.new('Москва')
  rr.stations << moscow_station
  orel_station = Station.new('Орел')
  rr.stations << orel_station
  saratov_station = Station.new('Саратов')
  rr.stations << saratov_station
  rr.routes << Route.new(moscow_station, saratov_station)
  rr.routes[0].add_station(orel_station)
  rr.trains << PassengerTrain.new(12345)
  rr.trains << CargoTrain.new(123-45)
  rr.wagons << PassengerWagon.new(100)
  rr.wagons << CargoWagon.new(1000)
  rr.trains[0].set_route(rr.routes[0])
  rr.trains[1].set_route(rr.routes[0])
  rr.trains[1].go_to_next_station
  rr.trains[0].add_wagon(rr.wagons[0])
  rr.trains[1].add_wagon(rr.wagons[1])
  #rr.show_stations_and_train
  rr.menu
end

seed
