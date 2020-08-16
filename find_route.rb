require './train_router.rb'
puts 'Specify the file path for the routes map'
path = gets.chomp
puts 'Insert the origin'
origin = gets.chomp
puts 'Insert the destination'
destination = gets.chomp
puts 'Enter the train color ("R": red | "G": green | Enter for none )'
train_color = gets.chomp
train_color = train_color.empty? ? nil : train_color
train_router = TrainRouter.new(path, origin, destination, train_color)
train_router.calculate_route
