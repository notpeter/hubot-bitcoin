# Description:
#   Find the latest Bitcoin price in specified currency
#
# Configuration:
#   None
#
# Commands:
#   hubot bitcoin                            - returns price in usd
#   hubot bitcoin list                       - returns list of available currencies
#   hubot bitcoin gbp                        - returns price in gbp
#
# Author:
#   Fred Wu
#   Peter Tripp <petertripp@gmail.com>

module.exports = (robot) ->
  robot.respond /bitcoin(?:\s)?(?:price\s)?(?:in\s)?(.*)?/i, (msg) ->
    currency = if (msg.match[1]) then msg.match[1].trim().toUpperCase() else 'USD'
    bitcoinPrice(msg, currency)

bitcoinPrice = (msg, currency) ->
  msg
    .http("https://api.bitcoinaverage.com/ticker/all")
    .get() (err, res, body) ->
      msg.send "#{getPrice(currency, body)}"

getPrice = (currency, body) ->
  values = JSON.parse(body)
  if currency == 'LIST'
    "Available currencies: " + ((k for k of values).filter (c) -> c isnt 'timestamp').join(' ')
  else if val = values[currency]
    "#{currency}: #{val.last} (H: #{val.ask} | L: #{val.bid})"
  else
    "Can't find the price for #{currency}. :("
