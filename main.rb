require_relative 'lib/market'
require_relative 'lib/interface'

market = Market.new
interface = Interface.new

puts "Welcome to Paymium ! Choose an action"
puts "-------------------------------------"
interface.actions
action_id = gets.chomp
interface.user_choice(market, action_id)

until action_id == "5" #action to exit program
  interface.actions
  action_id = gets.chomp
  interface.user_choice(market, action_id)
end 
