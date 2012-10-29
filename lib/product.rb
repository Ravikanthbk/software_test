# coding: UTF-8
class Product
  attr_accessor :products, :price, :items, :quantity
  def initialize(pricing_rules)
    @products = pricing_rules
    @price = {@products[0][:code] => @products[0][:price], 
      @products[1][:code] => @products[1][:price],
      @products[2][:code] => @products[2][:price]}
    @items = []
    @quantity = {}
  end

  def display_products
    puts "Product code \t Name \t\t Price \t\t Offer"
    puts "-" * 60
    @products.each do |product|
      puts "#{product[:code]} \t\t #{product[:name]} \t £ #{product[:price]} \t #{product[:offer]}"
    end
    select_menu_product
  end



  def select_product(product)
   code = []
   @products.each{|x| code << x[:code] }
   if code.include?(product)
     print "Enter the quantity for #{product} :"
     quantity = gets.chomp
     @items << product
     @quantity[product] = quantity
     puts "Added to Basket: #{product}"
     select_menu_product
   else
     puts "Invalid product code"
     select_menu_product
   end
  end

  def select_menu_product
    print 'For Menu press "M" or Enter "product code" for selecting item or press "C" for checkout:'
    product_menu = gets.chomp
    check_product(product_menu)
  end
end
