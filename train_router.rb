require 'json'
class TrainRouter
  def initialize(map_file_path, origin, destination, train_color)
    file = File.open map_file_path
    @stations_map = JSON.load file
    @origin = origin
    @destination = destination
    @train_color = train_color
    @shortest_route = nil
  end

  def calculate_route
    routes = [[@origin]]
    all_routes_calculated = routes_have_destination?(routes)
    until all_routes_calculated
      routes.each_with_index do |route, route_index|
        next if route.include?(@destination)

        last_station = @stations_map[route.last]
        base_route = routes.delete_at(route_index)
        last_station['links'].each do |linked_station|
          routes.push(base_route + [linked_station]) if can_pass?(base_route, linked_station)
        end
      end
      all_routes_calculated = routes_have_destination?(routes)
    end
    get_shortest_route(routes)
  end

  private

  def routes_have_destination?(routes)
    routes.all? { |route| route.include?(@destination) }
  end

  def get_shortest_route(routes)
    @shortest_route = routes.reduce do |short_route, route|
      route.length < short_route.length ? route : short_route
    end
    if @shortest_route.nil?
      'There are no possible routes.'
    else
      @shortest_route.join('->')
    end
  end

  def can_pass?(base_route, station)
    !base_route.include?(station) && (@stations_map[station]['color'] == @train_color || @train_color.nil? || @stations_map[station]['color'].nil?)
  end
end
