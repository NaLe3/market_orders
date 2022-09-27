require "bigdecimal"
require "pry"

class Market

  MARKET_ORDERS = {
    "bids"=>
    [], #array structure { ID: [, price €, BTC amount]}
   "base"=>"BTC",
   "quote"=>"EUR",
   "asks"=>
    []
  }

  def initialize
    @order_id = 0
  end

  

  def submit(order)
    if order[0] == "1"  #Order type: Bid 
     order.shift
     id = @order_id + 1 
     @order_id += 1 #increment for next market order
     MARKET_ORDERS["bids"] << { id => order}
    elsif order[0] == "2"  #Order type: Ask 
      order.shift
      order.unshift(@order_id + 1)
      id = @order_id + 1 
      @order_id += 1 #increment for next market order
      MARKET_ORDERS["asks"] << { id => order}
    end 
    puts "Order id: #{id}"
    binding.pry
  end

  def market_price
    # The market price (it is the average between the first buy order with maximum price and the first sell order with minimum price)
    buy_order_max_price = 0 
    sell_order_min_price = 0
    
    market_orders = MARKET_ORDERS

    market_orders["bids"].each do |bid|
      bids = []
      bids << BigDecimal.new(bid[1])
      buy_order_max_price = bids.max
    end

    market_orders["asks"].each do |ask|
      asks = []
      asks << BigDecimal.new(ask[1])
      sell_order_min_price = asks.min
    end

  BigDecimal.new((buy_order_max_price - sell_order_min_price) / 2) 
  end

  def market_depth
    MARKET_ORDERS
  end

  def cancel_order(id)

  end
end
