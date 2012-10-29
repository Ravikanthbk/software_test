# coding: UTF-8
require_relative "checkout"
DISCOUNT_ON_STRAWBERRIES = 4.5
pricing_rules = [{code:"FR1", name:"Fruit tea", price:3.11, offer:"Buy one get one free"},
 {code:"SR1", name:"Strawberries", price:5.00, offer:"Buy 3 or more strawberries and price drop to £ #{DISCOUNT_ON_STRAWBERRIES} on each"},
 {code:"CF1", name:"Coffee", price:11.23, offers:""}]
co = Checkout.new(pricing_rules)
co.display_products