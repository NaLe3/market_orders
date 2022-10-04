require "bigdecimal"
require "pry"

class Market

  MARKET_ORDERS = {
    "bids"=>
    {}, #hash structure { ID => [price €, BTC amount]}
   "base"=>"BTC",
   "quote"=>"EUR",
   "asks"=>
    {}  #hash structure { ID => [price €, BTC amount]}
  }

  ORDER_TYPE = {
    "1" => "bids",
    "2" => "asks"
  }

  def initialize
    @order_id = 1
    market_initializer
  end

  def submit(order_type_id, order)
    MARKET_ORDERS[ORDER_TYPE[order_type_id]][@order_id] = order
    @order_id += 1 #increment ID for next market order
    puts "Order id: #{@order_id}"
  end

  def market_price
    # The market price (it is the average between the first buy order with maximum price and the first sell order with minimum price)
    buy_order_max_price = 0 
    sell_order_min_price = 0
    
    MARKET_ORDERS["bids"].values.each do |bid|
      bids = []
      bids << BigDecimal(bid[0]) # bid[0] is the price € of eah order
      buy_order_max_price = bids.max
    end

    MARKET_ORDERS["asks"].values.each do |ask|
      asks = []
      asks << BigDecimal(ask[0]) # ask[0] is the price € of eah order
      sell_order_min_price = asks.min
    end

  
  puts BigDecimal((sell_order_min_price - buy_order_max_price) / 2) 
  end

  def market_depth
    puts MARKET_ORDERS
  end

  def cancel_order(id)
    return puts "Id does not exit" if !(0..@order_id ).to_a.include? id.to_i
    ORDER_TYPE.values.each do |type| 
      market = MARKET_ORDERS[type]
      market.delete(id.to_i) unless market[id.to_i].nil?
    end
   
    puts "Id:#{id}, has been deleted"
  end

  private 

  def market_initializer
    ORDER_TYPE.values.each do |order_type|
      initial_market[order_type].each do |order|
        MARKET_ORDERS[order_type][@order_id] = order
        @order_id += 1 
      end
    end
  end 

  def initial_market
    {
      "bids"=>
      [["2.00", "1.00000000"],
       ["1.80", "1.50000000"],
       ["1.60", "2.25000000"],
       ["1.40", "3.37500000"], 
       ["1.20", "5.06250000"],
       ["1.00", "7.59375000"],
       ["0.80", "11.39062500"],
       ["0.60", "17.08593750"]],
     "base"=>"BTC",
     "quote"=>"EUR",
     "asks"=>
      [["3.00", "1.00000000"],
       ["3.20", "1.50000000"],
       ["3.40", "2.25000000"],
       ["3.60", "3.37500000"],
       ["3.80", "5.06250000"],
       ["4.00", "7.59375000"],
       ["4.20", "11.39062500"],
       ["4.40", "17.08593750"]]
    }
  end

end
