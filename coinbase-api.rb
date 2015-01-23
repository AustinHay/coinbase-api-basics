#!/usr/bin/env ruby

require 'yaml'
require 'coinbase'

secrets = YAML::load(File.open('data.yml'))

# Test to make sure your secrets are working
# puts secrets['COINBASE_API_KEY']
# puts secrets['COINBASE_API_SECRET']

coinbase = Coinbase::Client.new(secrets['COINBASE_API_KEY'], secrets['COINBASE_API_SECRET'])
balance = coinbase.balance.to_s
print "Your current Coinbase balance is: #{balance} BTC \n"
print "Bitcoin price check. Enter the quantity of Bitcoins for purchase:\n"

q = gets.chomp
price = coinbase.buy_price(q).format
print "Currently, #{q} bitcoin are going for: #{price}"

# p x = coinbase.create_button "Give me a tip!", 500.to_money('USD'), "Austins Time and Expertise for 500 BTC!", "Tips"
# p x.button.code
# p x.embed_html



# Check Exchange Rates:
cb_rates = Money::Bank::Coinbase.new
# Download and display the rates from Coinbase
cb_rates.fetch_rates!

# Other Cool Coinbase commands:
# p coinbase.transactions
