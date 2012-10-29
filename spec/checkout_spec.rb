# coding: UTF-8
require 'spec_helper'
require_relative "../lib/checkout"
describe Checkout do
  DISCOUNT_ON_STRAWBERRIES = 4.5
  before do
    @pricing_rules = [{code:"FR1", name:"Fruit tea", price:3.11, offer:"Buy one get one free"},
    {code:"SR1", name:"Strawberries", price:5.00, offer:"Buy 3 or more strawberries and price drop to £ #{DISCOUNT_ON_STRAWBERRIES} on each"},
    {code:"CF1", name:"Coffee", price:11.23, offers:""}]
  end
  
  describe "initialize" do
    it "should initialize an object" do
      obj = Checkout.new @pricing_rules
      @pricing_rules.should == obj.products
      @pricing_rules[0][:code].should == obj.products[0][:code]
      @pricing_rules[0][:price].should == obj.products[0][:price]
    end
  end

  describe "check_product" do
    it "should display product menu list" do
      chk = Checkout.new @pricing_rules
      chk.should_receive(:display_products).and_return(true)
      chk.check_product("m")
    end

    it "should display checkout items list" do
      chk = Checkout.new @pricing_rules
      chk.should_receive(:checkout_items).and_return(true)
      chk.check_product("c")
    end

    it "should display select product from product menu list" do
      chk = Checkout.new @pricing_rules
      chk.should_receive(:select_product).with("FR1").and_return(true)
      chk.check_product("FR1")
    end
  end

  describe "checkout_items" do
    it "should display FR1 item, quantity and total price with buy one get one offer" do
      items = []
      check_items = ["FR1"]
      check_quantity = {"FR1" => 2}
      price_of_item = 3.11
      check_items.each do |item|
      (check_quantity[check_items.first].to_i * 2).times {|i| items << check_items.first}
      end
      total = check_quantity[check_items.first].to_i * @pricing_rules[0][:price].to_f
      chk = Checkout.new @pricing_rules
      chk.items = ["FR1"]
      chk.quantity = {"FR1" => 2}
      chk.should_receive(:puts).with("Basket: #{items.join(', ')}")
      chk.should_receive(:puts).with("Total price: #{total.round(2)}")
      total_price = chk.checkout_items
      check_items.should == chk.items
      check_quantity.should == chk.quantity
      total.round(2).should == total_price
    end
    
    it "should display SR1 item, quantity and total price with offer of buy 3
        or more strawberries and price drop to 4.5 from 5.0 on each" do
      items = []
      check_items = ["SR1"]
      check_quantity = {"SR1" => 4}
      price_of_item = 5.00
      check_items.each do |item|
      (check_quantity[check_items.first].to_i).times {|i| items << check_items.first}
      end
      total = check_quantity[check_items.first].to_i  * (check_quantity[check_items.first].to_i >= 3 ? DISCOUNT_ON_STRAWBERRIES : @pricing_rules[1][:price].to_f)
      chk = Checkout.new @pricing_rules
      chk.items = ["SR1"]
      chk.quantity = {"SR1" => 4}
      chk.should_receive(:puts).with("Basket: #{items.join(', ')}")
      chk.should_receive(:puts).with("Total price: #{total.round(2)}")
      total_price = chk.checkout_items
      check_items.should == chk.items
      check_quantity.should == chk.quantity
      total.round(2).should == total_price
    end

    it "should display CF1 item, quantity and total price" do
      items = []
      check_items = ["CF1"]
      check_quantity = {"CF1" => 2}
      price_of_item = 11.23
      check_items.each do |item|
      (check_quantity[check_items.first].to_i).times {|i| items << check_items.first}
      end
      total = check_quantity[check_items.first].to_i * @pricing_rules[2][:price].to_f
      chk = Checkout.new @pricing_rules
      chk.items = ["CF1"]
      chk.quantity = {"CF1" => 2}
      chk.should_receive(:puts).with("Basket: #{items.join(', ')}")
      chk.should_receive(:puts).with("Total price: #{total.round(2)}")
      total_price = chk.checkout_items
      check_items.should == chk.items
      check_quantity.should == chk.quantity
      total.round(2).should == total_price
    end
  end

end
