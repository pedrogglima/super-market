# frozen_string_literal: true

require_relative './super_market'

price_rules = SuperMarket::PriceRules.new
co = SuperMarket::Checkout.new(price_rules)

# Test data:

p 'Basket: GR1,SR1,GR1,GR1,CF1'
p 'Total price expected: £22.45'
p '-----------------------------'
co.scan('GR1')
co.scan('SR1')
co.scan('GR1')
co.scan('GR1')
co.scan('CF1')

p "Total: #{co.total}"
p "Total before discount: #{co.total_before_discount}"
p "Total discount: #{co.total_discount}"

co.clear_items

puts "\n\n"
p 'Basket: GR1,GR1'
p 'Total price expected: £3.11'
p '-----------------------------'
co.scan('GR1')
co.scan('GR1')

p "Total: #{co.total}"
p "Total before discount: #{co.total_before_discount}"
p "Total discount: #{co.total_discount}"

co.clear_items

puts "\n\n"
p 'Basket: SR1,SR1,GR1,SR1'
p 'Total price expected: £16.61'
p '-----------------------------'
co.scan('SR1')
co.scan('SR1')
co.scan('GR1')
co.scan('SR1')

p "Total: #{co.total}"
p "Total before discount: #{co.total_before_discount}"
p "Total discount: #{co.total_discount}"

co.clear_items

puts "\n\n"
p 'Basket: GR1,CF1,SR1,CF1,CF1'
p 'Total price expected: £30.57'
p '-----------------------------'
co.scan('GR1')
co.scan('CF1')
co.scan('SR1')
co.scan('CF1')
co.scan('CF1')

p "Total: #{co.total}"
p "Total before discount: #{co.total_before_discount}"
p "Total discount: #{co.total_discount}"

co.clear_items
