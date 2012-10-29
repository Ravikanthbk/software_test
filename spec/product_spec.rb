# coding: UTF-8
require 'spec_helper'
require_relative "../lib/checkout"
require_relative "../lib/product"
describe Product do
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
      obj.items.should == []
      obj.quantity.should == {}
    end
  end

  describe "display_products" do
    it "should display products list" do
      obj = Checkout.new @pricing_rules
      obj.should_receive(:puts).with("Product code \t Name \t\t Price \t\t Offer")
      obj.should_receive(:puts).with("-" * 60)
      @pricing_rules.each do |product|
        obj.should_receive(:puts).with("#{product[:code]} \t\t #{product[:name]} \t £ #{product[:price]} \t #{product[:offer]}")
      end
      obj.should_receive(:select_menu_product).and_return(true)
      obj.display_products
    end
  end

  describe "select_product" do
    it "should add products to basket" do
      count_quantity = {}
      obj = Checkout.new @pricing_rules
      code = ["FR1", "SR1", "CF1"]
      obj.should_receive(:print).with("Enter the quantity for FR1 :")
      quantity = 2
      stub!(:gets).and_return(quantity)
      obj.items << "FR1"
      obj.quantity["FR1"] = 2
      obj.should_receive(:puts).with("Added to Basket: FR1")
      obj.should_receive(:select_menu_product).and_return(true)
      obj.select_product("FR1")
    end

    it "should display error message if entry is invalid" do
      obj = Checkout.new @pricing_rules
      obj.should_receive(:puts).with("Invalid product code")
      obj.should_receive(:select_menu_product).and_return(true)
      obj.select_product("FR1123")
    end

  end

  describe "select_menu_product" do
    it "should select the entry to display menu or entry product code or checkout" do
      obj = Checkout.new @pricing_rules
      obj.should_receive(:print).with('For Menu press "M" or Enter "product code" for selecting item or press "C" for checkout:')
      product_menu = "m"
      stub!(:gets).and_return(product_menu)
      obj.should_receive(:check_product).and_return(true)
      obj.select_menu_product
    end
  end

end