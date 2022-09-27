require_relative 'lib/market'

market = Market.new

puts "Welcome to Paymium ! Choose an action"
puts "-------------------------------------"
puts "1: Submit an order"
puts "2: See market price"
puts "3: See market depth"
puts "4: cancel an order"

action = gets.chomp

if action == "1"
  puts "Press (1) for Bid order or (2) for Ask order"
  order_type = gets.chomp
  puts "Select a number of BTC"
  btc = gets.chomp
  puts "Select a price of EUR per BTC"
  eur = gets.chomp
  market.submit([order_type, btc, eur])
elsif action == "2"
  market.market_price
elsif action == "3"
  market.market_depth
elsif action == "4"
  puts "Please choose an order ID"
  id = gets.chomp
  cancel_order(id)
end 
