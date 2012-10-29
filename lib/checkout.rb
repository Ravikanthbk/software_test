# coding: UTF-8
require_relative "product"
class Checkout < Product
  def initialize(pricing_rules = [])
    super pricing_rules
  end

 def check_product(prdt_menu)
   case prdt_menu.downcase
   when "m"
    display_products
   when "c"
     checkout_items
   else
     select_product(prdt_menu)
   end
 end

 def checkout_items
   items = []
   total = 0
   @items.each do |item|
     case item
     when "FR1"
        (@quantity[item].to_i * 2).times {|i| items << item}
        total = total + (@quantity[item].to_i * @price[item].to_f)
     when "SR1"
       @quantity[item].to_i.times {|i| items << item}
       total = total + (@quantity[item].to_i  * (@quantity[item].to_i >= 3 ? DISCOUNT_ON_STRAWBERRIES : @price[item].to_f))
     when "CF1"
       @quantity[item].to_i.times {|i| items << item}
       total = total + (@quantity[item].to_i  * @price[item].to_f)
     else
       0
     end
   end
   total_price = total.round(2)
   puts "Basket: #{items.join(', ')}"
   puts "Total price: #{total_price}"
   total_price
 end
  
end


