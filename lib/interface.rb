class Interface

  def actions
    puts "1: Submit an order"
    puts "2: See market price"
    puts "3: See market depth"
    puts "4: cancel an order"
    puts "5: Exit Paymium"
  end 

  def user_choice(market, action_id)
    if action_id == "1"
      puts "Press (1) for Bid order or (2) for Ask order"
      order_type_id = gets.chomp
      puts "Select a number of BTC"
      btc = gets.chomp
      puts "Select a price of EUR per BTC"
      eur = gets.chomp
    puts "1: Submit an order"
      market.submit(order_type_id, [btc, eur])
    elsif action_id == "2"
      market.market_price
    elsif action_id == "3"
      market.market_depth
    elsif action_id == "4"
      puts "Please choose an order ID"
      id = gets.chomp
      market.cancel_order(id)
    elsif action_id == "5"
      puts "See you soon"
      exit
    end 
  end 

end
