require_relative 'controllers/menu_controller'

menu = MenuController.new #create menu object

system "clear" #clear command line
puts "Welcome to AddressBloc"

menu.main_menu #call methodls
